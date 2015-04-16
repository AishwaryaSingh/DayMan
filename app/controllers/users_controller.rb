class UsersController < ApplicationController
  
  def import
    if User.import(params[:file])
      flash[:success] = "Uploaded"
      redirect_to admin_users_path
    else
      flash[:error] = "Some error occured! Please try again!"
    end
  end

  def import_users
  end

	def index
    id=current_user.id
    @user=User.find(id)    
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
