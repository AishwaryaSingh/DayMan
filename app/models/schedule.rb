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

  def self.create_schedule(batch_ids,period,schedule_params,current_user)
    $day = "once"
    arr = batch_ids
    arr.each do |b|
      schedule = Schedule.new(schedule_params)
      schedule.batch_id = b
      schedule.period = period
      $period = period
      $start = schedule.start_date
      $end = schedule.end_date
      if $start == $end
        $period = "0"
      end
      $start_time = schedule.starttime
      $end_time = schedule.endtime
      if Schedule.validate_professor_availability(schedule) && Schedule.validate_room_availability(schedule) #&& !same_schedule(@schedule)
        if schedule.valid?
          schedule.name = schedule.subject_name+" by "+schedule.user_name+" in "+schedule.room_name+" for "+schedule.batch_name+"("+schedule.branch_name+")"
          schedule.save!
          if $period == "0" || $period.nil?
            $create_schedule_array.append([schedule,$day])
          else
            Schedule.create_repeating_events(schedule_params,b,$period)
          end
        end
      else
        Schedule.error_display(schedule)
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

  def self.create_repeating_events(schedule_params,b,period)
    $day = "once"
    while  $start<$end do
      schedule = Schedule.new(schedule_params)
      if $period == "1"
        schedule.start_date = schedule.start_date + 1.days
        schedule.starttime = $start_time + 1.days
        schedule.endtime = $end_time  + 1.days
        $start_time = $start_time + 1.days
        $end_time = $end_time + 1.days
        $start = $start + 1.days
        $day = "daily"
      elsif $period == "2"
        schedule.start_date = $start + 7.days
        schedule.starttime = $start_time + 7.days
        schedule.endtime = $end_time + 7.days
        $start_time = $start_time + 7.days
        $end_time = $end_time + 7.days
        $start = $start + 7.days
        $day = "weekly"
      else
        schedule.start_date = schedule.start_date + 28.days
        schedule.starttime = $start_time + 28.days
        schedule.endtime = $end_time + 28.days
        $start_time = $start_time + 28.days
        $end_time = $end_time + 28.days
        $start = $start + 28.days
        $day = "monthly"
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
    $create_schedule_array.append([schedule,$day])
    #Schedule.update_create_schedule_array(schedule,$day)
  end

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

  #when updating schedules
  def self.update_name_attribute(schedule)
    schedule.name = schedule.subject_name+" by "+schedule.user_name+" in "+schedule.room_name+" for "+schedule.batch_name+"("+schedule.branch_name+")"
    schedule.save!
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

#  Not create if schedule is exactly the SAME!!  NOT WORKING!!!!!!!
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

  def self.send_email(role_id, schedule, create_schedule, delete_schedule)
    t= false
    if !create_schedule.nil?
      if Schedule.create_email(create_schedule, role_id)  
        t = true     
      else
        t = false
      end
    end
    if !schedule.nil?
      if Schedule.update_email(schedule, role_id)
        t = true
      else
        t = false
      end
    end
    if !delete_schedule.nil?
      if Schedule.delete_email(delete_schedule,role_id)
        t=true
      else
        t=false
      end
    end
    return t
  end
  
  def self.create_email(schedule, role_id)
    if role_id == 1
      schedule.each do |schedule|
        professor_array = User.find_all_by_id(schedule[0].user_id)
        professor_array.each do |professor|
          ScheduleMailer.create_email(professor,schedule[0],schedule[1]).deliver
        end
      end
    end
    schedule.each do |schedule|
      student_array = User.find_all_by_batch_id_and_branch_id_and_semester_id(schedule[0].batch_id,schedule[0].branch_id,schedule[0].semester_id)
      student_array.each do |student|
        ScheduleMailer.create_email(student,schedule[0],schedule[1]).deliver
      end
    end
    Schedule.reinitialize_create
  end

  def self.reinitialize_create
    $create_schedule_array = []
  end

  def self.update_email(schedule, role_id)
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
    Schedule.reinitialize_update
  end

  def self.reinitialize_update
    $schedule_array = []
  end

  def self.delete_email(schedule, role_id)
    if role_id == 1
      schedule.each do |schedule|
        professor_array = User.find_all_by_id(schedule.user_id)
        professor_array.each do |user|
          ScheduleMailer.delete_email(user,schedule).deliver
        end
      end
    end
    schedule.each do |schedule|
      student_array = User.find_all_by_batch_id_and_branch_id_and_semester_id(schedule.batch_id,schedule.branch_id,schedule.semester_id)
      student_array.each do |user|
        ScheduleMailer.delete_email(user,schedule).deliver
      end
    end
    Schedule.reinitialize_delete
  end

  def self.reinitialize_delete
    $delete_schedule_array = []
  end

  def self.get_create_schedule_array
    return $create_schedule_array
  end

  def self.get_schedule_array
    return $schedule_array
  end

  def self.get_delete_schedule_array
    return $delete_schedule_array
  end

  def self.update_delete_array(schedule)
    $delete_schedule_array.append(schedule)
  end

  $delete_schedule_array = Array.new()
  $schedule_array = Array.new()
  $create_schedule_array = Array.new()

end
