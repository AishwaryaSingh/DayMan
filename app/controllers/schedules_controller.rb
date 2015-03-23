class SchedulesController < ApplicationController
	
  def index
    @schedules = Schedule.all
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

  def create
    @schedule = Schedule.new(params[:schedule])

    @schedule.save
    redirect_to schedules_path
  end

  def show
    @schedule = Schedule.find(params[:id])
  end

  def update
    @schedule = Schedule.find(params[:id])
        
    @schedule.update_attributes(params[:schedule])
    redirect_to schedules_path  
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy   
    redirect_to schedules_path
  end

end
