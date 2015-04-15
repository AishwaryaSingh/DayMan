class HomeController < ApplicationController
 
  def homepage
    if user_signed_in?
      if current_user.has_role? :admin 
        redirect_to admin_path
      elsif current_user.has_role? :student
        redirect_to student_path
      elsif current_user.has_role? :professor
        redirect_to professor_path
      else
<<<<<<< HEAD
        puts "I was here in HomePage"
        flash[:error] = "You don't have an assignned role yet! Sign out and sign in again to access default page!"
=======
>>>>>>> d3263fee77456336741f7617a7ec546d9deee27a
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
     redirect_to associate_path
    end
  end
end