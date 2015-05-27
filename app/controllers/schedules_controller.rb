class SchedulesController < ApplicationController
	
  def index

    @semester_id=params[:semester_id]
    @branch_id=params[:branch_id]
    @schedules = Schedule.find_all_by_batch_id_and_branch_id_and_semester_id( params[:batch_id], params[:branch_id], params[:semester_id])
   
    redirect_to new_schedule_path
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
      puts arr
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
    respond_to do |format|
      format.html
      format.json {render :json => @schedule }
    end
  end

  def new
    @schedule = Schedule.new
    @professor = User.find_all_by_role_id(2)
    @room = Room.all

    @branch_semester_subject = BranchSemesterSubject.find_all_by_branch_id_and_semester_id(params[:branch_id],params[:semester_id])
    @subject = @branch_semester_subject.collect! { |x| Subject.find(x.subject_id) }

    @subject.map{|i| i.id}
    @subjects = Subject.where(:id => @subject)
  #  @subjects = Subject.all   

    # puts "====================================================================="
    # puts "semester_id: #{params[:semester_id]} branch_id: #{params[:branch_id]}"
    # puts "====================================================================="
    # puts "branch_semester_subject: #{@branch_semester_subject.inspect}"  
    # puts "====================================================================="
    # puts "subjects: #{@subjects.inspect}"
    # puts "====================================================================="
  end

  def initialize_subjects
    branch_semester_subject = BranchSemesterSubject.find_all_by_branch_id_and_semester_id(params[:branch_id],params[:semester_id])
    subjects = branch_semester_subject.collect! { |x| Subject.find(x.subject_id) }
    puts "====================================================================="
    puts "semester_id: #{params[:semester_id]} branch_id: #{params[:branch_id]}"
    puts "====================================================================="
    puts "branch_semester_subject: #{branch_semester_subject.inspect}"  
    puts "====================================================================="
    puts "subjects: #{subjects.inspect}"
    puts "====================================================================="
    respond_to do |format|
      format.json {render :json => subjects }
    end
  end

  def create
    arr = params[:batch_ids]
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
    puts "=========================================================================================="
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
