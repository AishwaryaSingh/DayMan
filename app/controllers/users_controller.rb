class UsersController < ApplicationController

  def index
    @schedule = Schedule.new
    id=current_user.id
    @user=User.find(id)
    @data = User.save_event_to_display(current_user)
    respond_to do |format|
      format.html
      format.json { render :json => @data }
    end
  end

  def show
    @user = current_user
    @schedule = Schedule.new
    @professor = User.find_all_by_role_id(2)
    @branch =Branch.all
    @semester = Semester.all
    @batch = Batch.all
    @room = Room.all
    @subjects = Subject.all
    @data = User.save_event_to_display(current_user)  
    respond_to do |format|  
      format.html
      format.json { render :json => @data }  
    end 
  end

  def import
    if params[:file]
      if User.import(params[:file])
        flash[:success] = "Uploaded"
        redirect_to admin_users_path
      else
        flash[:error] = "Some error occured! Please try again!"
        @errors=User.import(params[:file])
        redirect_to :back
      end
    else
      flash[:error] = "Choose a file to import!"
      redirect_to :back
    end
  end

  def new
    @user=User.new
    @roles = Role.all
    @semester = Semester.all
    @batch = Batch.all
    @branch = Branch.all
  end

  def create_user
    if user_params.nil?
      flash[:error] = "Enter Data!"
    else
      @user=User.new(user_params)
      @user.password = "12345678"
      @user.sign_up_count = "1"
      if @user.save!
        UserMailer.welcome_email(@user).deliver
        flash[:success] = "Created a New User!"
      else
        flash[:error] = "User not created."
      end
      redirect_to admin_users_path
    end
  end

  def id_for_edit
    user_id=params[:user_id]
    if user_id == ""
      flash[:error] = "Enter an ID to edit!"
      redirect_to :back
    elsif !User.find_by_id(user_id)
      flash[:error] = "Enter a VALID ID to edit!"
      redirect_to :back
    else 
      @user=User.find_by_id(user_id)
      redirect_to edit_user_path(@user)
    end
  end

  def edit
    @user = User.find(params[:id])
    @roles = Role.all
    @semester = Semester.all
    @batch = Batch.all
    @branch = Branch.all
  end

  def update_user
    @user = User.find(params[:user][:id])
    if @user.update_attributes!(user_params)
      flash[:success] = "Updated User "+@user.name
    else
      flash[:error] = "User not updated."
    end
    redirect_to admin_users_path
  end

  def destroy
    @user = User.find(params[:id])
    flash[:success] = "Deleted User "+@user.name
    @user.destroy
    redirect_to admin_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:id,:role_id,:batch_id,:semester_id,:branch_id)
  end


end
