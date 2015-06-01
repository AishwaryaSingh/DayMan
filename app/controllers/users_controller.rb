class UsersController < ApplicationController
  
  def index
    @schedule = Schedule.new
    id=current_user.id
    @user=User.find(id)

      if current_user.role.name == "professor"
        @data=Schedule.find_all_by_user_id(current_user.id)
        @data.each do |d|
          d.name= d.subject.name+" for "+d.batch.name+" in "+d.room.name  #FULCALENDAR TITLE FOR PROFESSOR
          d.save!
        end
      else
        @data=Schedule.find_all_by_batch_id_and_semester_id_and_branch_id(current_user.batch_id,current_user.semester_id,current_user.branch_id)
        @data.each do |d|
          d.name= d.subject.name+" by "+d.user.name+" in "+d.room.name  #FULCALENDAR TITLE FOR STUDENT
          d.save!
        end
      end
      respond_to do |format|  
        format.html # index.html.erb  
        format.json { render :json => @data }  
     end   

  end

  def schedule
    @user = current_user
    #++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        @schedule = Schedule.new
        @professor = User.find_all_by_role_id(2)
        @branch =Branch.all
        @semester = Semester.all
        @batch = Batch.all
        @room = Room.all

        #@branch_semester_subject = BranchSemesterSubject.find_all_by_branch_id_and_semester_id(params[:branch_id],params[:semester_id])
        #@subject = @branch_semester_subject.collect! { |x| Subject.find(x.subject_id) }

        #@subject.map{|i| i.id}
        #@subjects = Subject.where(:id => @subject)

        @subjects = Subject.all   
    #++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      @data=Schedule.find_all_by_user_id(current_user.id)
      @data.each do |d|
        d.name= d.subject.name+" for "+d.batch.name+" in "+d.room.name  #FULCALENDAR TITLE FOR PROFESSOR
        d.save!
      end
    respond_to do |format|  
      format.html # index.html.erb  
      format.json { render :json => @data }  
   end 
  end

  def import
    if User.import(params[:file])
      flash[:success] = "Uploaded"
      redirect_to admin_users_path
    else
      flash[:error] = "Some error occured! Please try again!"
    end
  end
end
