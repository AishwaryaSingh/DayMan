class SchedulesController < ApplicationController
	
  def index
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    @schedules = Schedule.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules }
    end

  end

  def new
    @schedule = Schedule.new
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! In new !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

  end

  def edit
    @schedule = Schedule.find(params[:id])
  end

  def create
    @schedule = Schedule.new(schedule_params)
 puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! In create !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    if @schedule.valid?
      @schedule.name= @schedule.subject.name+" by "+@schedule.user.name+" in "+@schedule.room.name+" for "+@schedule.batch.name+"("+@schedule.branch.name+")"
      @schedule.save

 puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Rendering new !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      render 'new'
    else

 puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! In form !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      render 'form'
    end
  end

  def show
 puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! In show !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
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
