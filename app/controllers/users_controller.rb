class UsersController < ApplicationController
  
  def import
    if Uaser.import(params[:file])
      flash[:success] = "Uploaded"
      redirect_to students_path
    else
      flash[:error] = "Some error occured! Please try again!"
    end
  end
  
	def index
    redirect_to new_user_session_path
	end

  private

  def ensure_admin!
    unless current_user.admin?
      sign_out current_user

      redirect_to root_path

      return false
    end
  end

end
