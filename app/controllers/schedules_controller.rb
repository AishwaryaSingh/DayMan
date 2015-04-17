class SchedulesController < ApplicationController
	
  def index
    @schedules = Schedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules }
    end

  end

  def get_schedule(uid)
#    @data=Schedule.find_by_user_id(uid)
  end

  def show
    @schedule = Schedule.all #find(params[:id])
  end

  def new
    @schedule = Schedule.new
  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def create_more
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.valid?
      @schedule.save
      render 'new'
    else
      render 'form'
    end
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
        
    @schedule.update_attributes(schedule_params)
    redirect_to schedules_path  
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy   
    redirect_to schedules_path
  end

  private

  def schedule_params
    params.require(:schedule).permit(:branch_id, :semester_id, :user_id, :subject_id, :batch_id, :room_id, :starttime , :endtime, :unit_id, :room_id, :starttime , :endtime )
  end

end
