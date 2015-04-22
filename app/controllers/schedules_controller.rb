class SchedulesController < ApplicationController
	
  def index
    @schedules = Schedule.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules }
    end
  end

  def new
    @schedule = Schedule.new
    @all_schedules = Schedule.all

  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def create
    respond_to do |format|
       format.html {render text: "Your data was sucessfully loaded. Thanks"}
       format.json{render :json => @schedule, :status => :created, :location => @schedule }
    end
    puts "In schedule create() !!!!!!!!!!!!!!!!!!!!!"     
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
