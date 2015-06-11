class Schedule < ActiveRecord::Base

  belongs_to :branch
  belongs_to :semester
  belongs_to :subject
  belongs_to :user
  belongs_to :batch
  belongs_to :room

  delegate :name, :to => :subject, :prefix => true
  delegate :name, :to => :user, :prefix => true
  delegate :name, :to => :room, :prefix => true
  delegate :name, :to => :batch, :prefix => true
  delegate :name, :to => :branch, :prefix => true
  delegate :name, :to => :semester, :prefix => true

	validates :branch_id , presence: true
  validates :semester_id , presence: true
  validates :user_id , presence: true
	validates :subject_id , presence: true
 	validates :batch_id , presence: true
  validates :room_id , presence: true

  def self.update_email(schedule , role_id)
    if role_id == 1
      schedule.each do |schedule|
        professor_array = User.find_all_by_id(schedule.user_id)
        professor_array.each do |user|
          ScheduleMailer.update_email(user,schedule).deliver
        end
      end
    end
    schedule.each do |schedule|
      student_array = User.find_all_by_batch_id_and_branch_id_and_semester_id(schedule.batch_id,schedule.branch_id,schedule.semester_id)
      student_array.each do |user|
        ScheduleMailer.update_email(user,schedule).deliver
      end
    end
    Schedule.reinitialize_array
  end

  def self.reinitialize_array
    $schedule_array = []
  end

  def self.update_schedule_array(schedule)
    t = false
    $schedule_array.each do |s|
      if s.id == schedule.id
        $schedule_array.delete(s)
        $schedule_array.append(schedule)
        t = true
        break
      end
    end
    if t == false
      $schedule_array.append(schedule)
    end
  end

  def self.get_schedule_array
    return $schedule_array
  end


  def self.update_name_attribute(schedule)
    schedule.name = schedule.subject_name+" by "+schedule.user_name+" in "+schedule.room_name+" for "+schedule.batch_name+"("+schedule.branch_name+")"
    schedule.save!
  end

  def self.create_schedule(batch_ids,period,schedule_params,current_user)
    $schedules = Array.new()
    arr = batch_ids
    arr.each do |b|
      schedule = Schedule.new(schedule_params)
      schedule.batch_id = b
      schedule.period = period
      $period = period
      $start = schedule.start_date
      $end = schedule.end_date
      $start_time = schedule.starttime
      $end_time = schedule.endtime
      if Schedule.validate_professor_availability(schedule) && Schedule.validate_room_availability(schedule) #&& !same_schedule(@schedule)
        if schedule.valid?
          schedule.name = schedule.subject_name+" by "+schedule.user_name+" in "+schedule.room_name+" for "+schedule.batch_name+"("+schedule.branch_name+")"
          schedule.save!
          $schedules.append(schedule)
          if period != "0"
            Schedule.create_repeating_events(schedule_params,b,$period)
          end
        end
      else
        Schedule.error_display(schedule)
      end
      if current_user.role_id == 1
        $schedules.each do |s|
          Schedule.update_schedule_array(s)
        end
      end
    end
  end

  def self.create_repeating_events(schedule_params,b,period)
    while  $start<$end do
      schedule = Schedule.new(schedule_params)
      if $period == "1"
        schedule.start_date = schedule.start_date + 1.days
        schedule.starttime = $start_time + 1.days
        schedule.endtime = $end_time  + 1.days
        $start_time = $start_time + 1.days
        $end_time = $end_time + 1.days
        $start = $start + 1.days
      elsif $period == "2"
        schedule.start_date = $start + 7.days
        schedule.starttime = $start_time + 7.days
        schedule.endtime = $end_time + 7.days
        $start_time = $start_time + 7.days
        $end_time = $end_time + 7.days
        $start = $start + 7.days
      else
        schedule.start_date = schedule.start_date + 28.days
        schedule.starttime = $start_time + 28.days
        schedule.endtime = $end_time + 28.days
        $start_time = $start_time + 28.days
        $end_time = $end_time + 28.days
        $start = $start + 28.days
      end
      if $start<=$end
        schedule.batch_id = b
        schedule.period = period
        if validate_professor_availability(schedule) && validate_room_availability(schedule) #&& !same_schedule(@schedule)
          if schedule.valid?
            schedule.name = schedule.subject_name+" by "+schedule.user_name+" in "+schedule.room_name+" for "+schedule.batch_name+"("+schedule.branch_name+")"
            schedule.save!
          end
        end
      end
    end
  end

  def self.error_display(schedule)
    if !Schedule.validate_professor_availability(schedule)
      flash[:error] = "That PROFESSOR is NOT AVAILABLE during that time!"
    elsif !Schedule.validate_room_availability(schedule) && !Schedule.validate_professor_availability(schedule)
      flash[:error] = "Professor and Room BOTH are NOT AVAILABLE!"
    else
      flash[:error] = "That ROOM is NOT AVAILABLE during that time!"
    end
  end

  # Not create if schedule is exactly the SAME!!  NOT WORKING!!!!!!!
#  def self.same_schedule(schedule)
#    schedule_all = Schedule.find_all_by_user_id_and_room_id(schedule.user_id, schedule.room_id)
#    schedule_all.each do |s|
#      if s.starttime.to_s == schedule.starttime.to_s && s.endtime.to_s == schedule.endtime.to_s
#        if s.batch_id == schedule.batch_id && s.branch_id == schedule.branch_id && s.semester_id == schedule.semester_id
#          return true
#        end
#      else
#        return false
#      end
#    end
#  end

  def self.validate_professor_availability(schedule)
    schedule_all = Schedule.find_all_by_user_id(schedule.user_id)
    schedule_all.each do |s|
      if s.starttime.to_s == schedule.starttime.to_s && s.endtime.to_s == schedule.endtime.to_s && s.room_id.to_s != schedule.room_id.to_s
        return false
      else
        return true
      end
    end
  end

  def self.validate_room_availability(schedule)
    schedule_all = Schedule.find_all_by_room_id(schedule.room_id)
    schedule_all.each do |s|
      if s.starttime.to_s == schedule.starttime.to_s && s.endtime.to_s == schedule.endtime.to_s && s.user_id.to_s != schedule.user_id.to_s
        return false
      else
        return true
      end
    end
  end
end
