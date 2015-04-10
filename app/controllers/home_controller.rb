class HomeController < ApplicationController
 
  def homepage
    if user_signed_in?
      if current_user.has_role? :admin
        puts "I was here in HomePage admin"
        redirect_to admin_path
      elsif current_user.has_role? :student
        puts "I was here in HomePage student"
        redirect_to studenthome_path
      elsif current_user.has_role? :professor
        puts "I was here in HomePage professor"
        redirect_to professorhome_path
      else
        puts "I was here in HomePage"
        redirect_to home_path
      end
    else
      redirect_to new_user_session_path
    end
  end

  def index
  end

  def professorhome
  end
  def studenthome
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
     redirect_to associate_path
    end
  end
end