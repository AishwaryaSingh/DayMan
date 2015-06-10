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
    @schedule = Schedule.create_schedule(params[:batch_ids],params[:period],schedule_params,current_user)
    if current_user.role_id == "1"
      $schedule_array.append(@schedule)
    end
    respond_to do |format|
      format.html
      format.json {render :json => @schedule, :status => :created, :location => @schedule }
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
    @schedule = Schedule.find(params[:id])
    if @schedule.valid?
      @schedule.update_attributes(schedule_params)
      Schedule.update_name_attribute(@schedule)
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
