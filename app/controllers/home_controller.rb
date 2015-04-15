class HomeController < ApplicationController
 
  def homepage
    if user_signed_in?
      puts "!!!!!!!!!!!!!!!!"
      puts current_user.sign_in_count
      puts current_user.role.name
      puts "!!!!!!!!!!!!!!!!"
      if current_user.sign_in_count == 1
        puts "First Time"
        redirect_to edit_user_registration_path
      else
        roles_homepage
      end
    else 
      render 'welcome'
    end
  end

  def index
  end
  
  def welcome_msg
    UserMailer.welcome_email(self).deliver_now # unless self.invalid?
  end

  private

  def roles_homepage
    if current_user.role.name == "admin"
      redirect_to admin_path
    elsif current_user.role.name == "professor"
      redirect_to professors_path
    elsif current_user.role.name == "student"
      redirect_to students_path
    else
      redirect_to home_path
    end
  end

end