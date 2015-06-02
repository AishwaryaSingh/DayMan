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
      format.html
      format.json { render :json => @data }  
   end   
  end

  def schedule
    @user = current_user
    @schedule = Schedule.new
    @professor = User.find_all_by_role_id(2)
    @branch =Branch.all
    @semester = Semester.all
    @batch = Batch.all
    @room = Room.all
    @subjects = Subject.all   
    @data=Schedule.find_all_by_user_id(current_user.id)
    @data.each do |d|
      d.name= d.subject.name+" for "+d.batch.name+" in "+d.room.name  #FULCALENDAR TITLE FOR PROFESSOR
      d.save!
    end
    respond_to do |format|  
      format.html
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

  def new
    @user=User.new
    @roles = Role.all
    @semester = Semester.all
    @batch = Batch.all
    @branch = Branch.all
  end

  def create
    @user=User.new(user_params)
    @user.save!
    flash[:success] = "Created a New User"
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    flash[:success] = "Deleted User "+@user.name
    @user.destroy
    redirect_to admin_users_path
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.all
    @semester = Semester.all
    @batch = Batch.all
    @branch = Branch.all
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes!(user_params)
    flash[:success] = "Updated User "+@user.name
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:id,:role_id,:batch_id,:semester_id,:branch_id)
  end


end
