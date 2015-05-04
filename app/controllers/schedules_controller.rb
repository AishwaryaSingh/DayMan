class SchedulesController < ApplicationController
	
  def index
    @schedules = Schedule.find_all_by_batch_id_and_branch_id_and_semester_id( params[:batch_id], params[:branch_id], params[:semester_id])
    respond_to do |format|
      format.html
      format.json { render json: @schedules }
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
      @schedule.name = @schedule.subject.name+" by "+@schedule.user.name+" in "+@schedule.room.name+" for "+@schedule.batch.name+"("+@schedule.branch.name+")"
      @schedule.save!
    end
    respond_to do |format|
      format.html
      format.json {render :json => @schedule }
    end
  end

  def new
    @schedule = Schedule.new
  end

  def create
    puts "here"
    arr = params[:batch_ids]
    puts arr
    arr.each do |b|
      @schedule = Schedule.new(schedule_params)
      @schedule.batch_id = b
      if @schedule.valid?
        @schedule.name = @schedule.subject.name+" by "+@schedule.user.name+" in "+@schedule.room.name+" for "+@schedule.batch.name+"("+@schedule.branch.name+")"
        @schedule.save!
      end
    end
    respond_to do |format|
      format.html
      format.json {render :json => @schedule, :status => :created, :location => @schedule }
    end
  end

  def validate_professor_availability(schedule)
    schedule_all = Schedule.find_all_by_user_id(schedule.user_id)
    schedule_all.each do |s|
      if s.starttime == schedule.starttime && s.endtime == schedule.endtime
        return true
      else
        return false
      end
    end
  end

  def validate_room_availability(schedule)
    schedule_all = Schedule.find_all_by_room_id(schedule.room_id)
    schedule_all.each do |s|
      if s.starttime == schedule.starttime && s.endtime == schedule.endtime
        return true
      else
        return false
      end
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
    params.require(:schedule).permit(:name, :branch_id, :semester_id, :user_id, :subject_id, :batch_id, :room_id, :starttime , :endtime, :batch_ids=>[])
  end

end
