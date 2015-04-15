class HomeController < ApplicationController
 
  def homepage
    if user_signed_in? 
      roles_homepage
    else 
      render 'welcome'
    end
  end

  def welcome
  end

  def index
  end

  def professorhome
  end
  def studenthome
    @student= Student.all
  end

  private

  def roles_homepage
    if current_user.has_role? :admin
      redirect_to admin_path
    elsif current_user.has_role? :professor
      redirect_to professor_path
    elsif current_user.has_role? :student
      redirect_to student_path
    else
      redirect_to home_path
    end
  end

end