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
    if current_user.password == "12345678"
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
      redirect_to admin_path #and return
    elsif current_user.role.name == "professor"
      redirect_to professors_path #and return
    elsif current_user.role.name == "student"
      redirect_to students_path #and return
    else
      redirect_to home_path
    end
  end
end