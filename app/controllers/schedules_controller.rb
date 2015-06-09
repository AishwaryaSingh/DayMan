class SchedulesController < ApplicationController
	
  def new    
    @branch_id_frmc = params[:branch_id]
    @semester_id_frmc = params[:semester_id]
    @batch_id_frmc = params[:batch_id]
    @schedule = Schedule.new
    @professor = User.find_all_by_role_id(2)
    @branch =Branch.all
    @semester = Semester.all
    @batch = Batch.all
    @room = Room.all
    @subjects = Subject.all
    @schedules = Schedule.find_all_by_batch_id_and_branch_id_and_semester_id( params[:batch_id], params[:branch_id], params[:semester_id])
    respond_to do |format|
      format.html
      format.json  { render :json => { :schedules => @schedules } }
    end
  end

  def initialize_subjects    
    @branch_id_frmc = params[:branch_id]
    @semester_id_frmc = params[:semester_id]
    @batch_id_frmc = params[:batch_id]
    branch_semester_subject = BranchSemesterSubject.find_all_by_branch_id_and_semester_id(params[:branch_id],params[:semester_id])
    @subjects = branch_semester_subject.collect! { |x| Subject.find(x.subject_id) }
    @schedule = Schedule.new
    @professor = User.find_all_by_role_id(2)
    @branch =Branch.all
    @semester = Semester.all
    @batch = Batch.all
    @room = Room.all
    @schedules = Schedule.find_all_by_batch_id_and_branch_id_and_semester_id( params[:batch_id], params[:branch_id], params[:semester_id])
    render :new
  end

  def create
    arr = params[:batch_ids]
    arr.each do |b|
      @schedule = Schedule.new(schedule_params)
      @schedule.batch_id = b
      @schedule.period = params[:period]
      $period = params[:period]
      $start = @schedule.start_date
      $end = @schedule.end_date
      $start_time = @schedule.starttime
      $end_time = @schedule.endtime
      if validate_professor_availability(@schedule) && validate_room_availability(@schedule) #&& !same_schedule(@schedule)
        if @schedule.valid?
          @schedule.name = @schedule.subject.name+" by "+@schedule.user.name+" in "+@schedule.room.name+" for "+@schedule.batch.name+"("+@schedule.branch.name+")"
          @schedule.save!
          if params[:period] != "0"
            while  $start<$end do
              @schedule = Schedule.new(schedule_params)
              if $period == "1"
                @schedule.start_date = @schedule.start_date + 1.days
                @schedule.starttime = $start_time + 1.days
                @schedule.endtime = $end_time  + 1.days 

                $start_time = $start_time + 1.days
                $end_time = $end_time + 1.days
                $start = $start + 1.days
              elsif $period == "2"
                @schedule.start_date = $start + 7.days
                @schedule.starttime = $start_time + 7.days
                @schedule.endtime = $end_time + 7.days
                
                $start_time = $start_time + 7.days
                $end_time = $end_time + 7.days
                $start = $start + 7.days
              else
                @schedule.start_date = @schedule.start_date + 28.days
                @schedule.starttime = $start_time + 28.days
                @schedule.endtime = $end_time + 28.days  
                
                $start_time = $start_time + 28.days
                $end_time = $end_time + 28.days
                $start = $start + 28.days
              end
              if $start<=$end
                @schedule.batch_id = b
                @schedule.period = params[:period]
                if validate_professor_availability(@schedule) && validate_room_availability(@schedule) #&& !same_schedule(@schedule)
                  if @schedule.valid?
                    @schedule.name = @schedule.subject.name+" by "+@schedule.user.name+" in "+@schedule.room.name+" for "+@schedule.batch.name+"("+@schedule.branch.name+")"
                    @schedule.save!
                  end
                end
              end
            end 
          end
        end
      else
        if !validate_professor_availability(@schedule)
          flash[:error] = "That PROFESSOR is NOT AVAILABLE during that time!"
        elsif !validate_room_availability(@schedule) && !validate_professor_availability(@schedule)
          flash[:error] = "Professor and Room BOTH are NOT AVAILABLE!"
        else
          flash[:error] = "That ROOM is NOT AVAILABLE during that time!"
        end            
      end
    end
    if current_user.role_id == "1"
      $schedule_array.append(@schedule)
    end
    respond_to do |format|
      format.html
      format.json {render :json => @schedule, :status => :created, :location => @schedule }
    end
  end

# Not create if schedule is exactly the SAME!!  NOT WORKING!!!!!!!
  def same_schedule(schedule)
    schedule_all = Schedule.find_all_by_user_id_and_room_id(schedule.user_id, schedule.room_id)
    schedule_all.each do |s|
      if s.starttime.to_s == schedule.starttime.to_s && s.endtime.to_s == schedule.endtime.to_s
        if s.batch_id == schedule.batch_id && s.branch_id == schedule.branch_id && s.semester_id == schedule.semester_id
          return true
        end
      else
        return false
      end
    end
  end

  def validate_professor_availability(schedule)
    schedule_all = Schedule.find_all_by_user_id(schedule.user_id)
    schedule_all.each do |s|
      if s.starttime.to_s == schedule.starttime.to_s && s.endtime.to_s == schedule.endtime.to_s && s.room_id.to_s != schedule.room_id.to_s
        return false
      else
        return true
      end
    end
  end

  def validate_room_availability(schedule)
    schedule_all = Schedule.find_all_by_room_id(schedule.room_id)
    schedule_all.each do |s|
      if s.starttime.to_s == schedule.starttime.to_s && s.endtime.to_s == schedule.endtime.to_s && s.user_id.to_s != schedule.user_id.to_s
        return false
      else
        return true
      end
    end
  end

  def edit
    @schedule = Schedule.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render :json => @schedule }
    end
  end

  def update
    if params[:batch_ids]
      arr = params[:batch_ids]
      arr.each do |b|
        @schedule = Schedule.find(params[:id])
        if @schedule.valid?
          @schedule.update_attributes(schedule_params)
          @schedule.name = @schedule.subject.name+" by "+@schedule.user.name+" in "+@schedule.room.name+" for "+@schedule.batch.name+"("+@schedule.branch.name+")"
          @schedule.save!
        end
      end
    else
      @schedule = Schedule.find(params[:id])
      if @schedule.valid?
        @schedule.update_attributes(schedule_params)
        @schedule.name = @schedule.subject.name+" by "+@schedule.user.name+" in "+@schedule.room.name+" for "+@schedule.batch.name+"("+@schedule.branch.name+")"
        @schedule.save!
      end
    end
    t = false
    $schedule_array.each do |s|
      if s.id == @schedule.id
        $schedule_array.delete(s)
        $schedule_array.append(@schedule)
        t = true
        break
      end
    end
    if t == false
      $schedule_array.append(@schedule)
    end
    respond_to do |format|
      format.html
      format.json {render :json => @schedule }
    end
  end

# for when the schedule is changed and the mail needs to be sent
  def update_schedule
    @role_id = current_user.role_id
    @schedule = $schedule_array
    if Schedule.update_email(@schedule, @role_id) 
      flash[:success] = "Users Notified!"
      $schedule_array = []
      redirect_to root_path
    else
      flash[:error] = "Some error occured! Please try again!"
    end
  end

# for creating recurring event in the given range
  def generate_events_in_range(start_date, end_date)
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    respond_to do |format|
      format.html
      format.json {render :json => @schedule }
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:name, :branch_id, :semester_id, :user_id, :subject_id, :batch_id, :room_id, :starttime, :endtime, :start_date,  :end_date, :period, :batch_ids=>[])
  end

  $schedule_array = Array.new()

end
