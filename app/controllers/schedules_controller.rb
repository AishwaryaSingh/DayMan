class SchedulesController < ApplicationController
	
  def index
    @schedules = Schedule.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @schedules }
    end
  end

  def edit
    @schedule = Schedule.find(params[:id]) #schedule_params) #params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json {render :json => @schedule }
    end
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.valid?
      @schedule.update_attributes(schedule_params)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json {render :json => @schedule }
    end
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.valid?
      @schedule.name= @schedule.subject.name+" by "+@schedule.user.name+" in "+@schedule.room.name+" for "+@schedule.batch.name+"("+@schedule.branch.name+")"
      @schedule.save
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json {render :json => @schedule, :status => :created, :location => @schedule }
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    puts @schedule
    @schedule.destroy   
    respond_to do |format|
      format.html # index.html.erb
      format.json {render :json => @schedule }
    end
  end

  private

  def schedule_params
    params.require(:schedule).permit(:name, :branch_id, :semester_id, :user_id, :subject_id, :batch_id, :room_id, :starttime , :endtime)
  end

end
