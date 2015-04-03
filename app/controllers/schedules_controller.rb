class SchedulesController < ApplicationController
	
  def index
    @schedules = Schedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules }
    end

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

    @schedule.save!

    redirect_to new_schedule_path
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
    params.require(:schedule).permit(:unit_id, :room_id, :starttime , :endtime )
  end

end
