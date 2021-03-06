class SchedulesController < ApplicationController
	
  def new
    @branch_id_frmc = params[:branch_id]
    @semester_id_frmc = params[:semester_id]
    @batch_id_frmc = params[:batch_id]
    @schedule = Schedule.new
    @professor = User.find_all_by_role_id([2,4])
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
    if !params[:branch_id].nil? && !params[:semester_id].nil? && !params[:batch_id].nil?
    @branch_id_frmc = params[:branch_id]
    @semester_id_frmc = params[:semester_id]
    @batch_id_frmc = params[:batch_id]
    branch_semester_subject = BranchSemesterSubject.find_all_by_branch_id_and_semester_id(params[:branch_id],params[:semester_id])
    @subjects = branch_semester_subject.collect! { |x| Subject.find(x.subject_id) }
    @schedule = Schedule.new
    @professor = User.find_all_by_role_id([2,4])
    @branch =Branch.all
    @semester = Semester.all
    @batch = Batch.all
    @room = Room.all
    @schedules = Schedule.find_all_by_batch_id_and_branch_id_and_semester_id( params[:batch_id], params[:branch_id], params[:semester_id])
    render :new
  else
    flash[:error]="Select Values!"
     render :new
  end
  end

  def create
    Schedule.create_schedule(params[:batch_ids],params[:period],schedule_params,current_user)
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
    $batch_id=@schedule.batch_id
    Schedule.update_schedule(@schedule,$batch_id,params[:period],params[:batch_ids],schedule_params,current_user)
    Schedule.update_schedule_array(@schedule)
    respond_to do |format|
      format.html
      format.json {render :json => @schedule }
    end
  end

# for when the schedule is changed and the mail needs to be sent
  def update_schedule
    role_id = current_user.role_id
    schedule = Schedule.get_schedule_array
    create_schedule = Schedule.get_create_schedule_array
    delete_schedule = Schedule.get_delete_schedule_array
    if Schedule.send_email(role_id,schedule,create_schedule,delete_schedule)
      flash[:success] = "Users Notified!"
      redirect_to root_path
    else
      flash[:error] = "Some error occured! Please try again!"
      redirect_to (:back)
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    Schedule.update_delete_array(@schedule)
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
end
