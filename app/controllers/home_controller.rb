class HomeController < ApplicationController
 
  def homepage
    if user_signed_in?
      if current_user.sign_up_count == 1 
        redirect_to edit_user_registration_path
        check_sign_up_count
      else
        roles_homepage
      end
    else 
      redirect_to new_user_session_path
    end
  end

  def check_sign_up_count
    if current_user.password == "12345678"  #Default password on excel uplaod
      return false
    else
      current_user.sign_up_count ="0"
      current_user.save!
      return true
    end
  end

  def index
  end

  private

  def roles_homepage
    if current_user.role.name == "admin"
      redirect_to admin_path
    elsif current_user.role.name == "professor"
      redirect_to users_path
    elsif current_user.role.name == "student"
      redirect_to users_path
    else
      redirect_to home_path
    end
  end
end