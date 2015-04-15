class UserMailer < ApplicationMailer

#	before_filter :set_url
#	default from: ""
	
#	include Users::AdminsHelper	
#	helper :updates
	
  default from: 'notifications@example.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://http://localhost:3000/users'
    mail(to: user.email, subject: 'Welcome to Day Manager!')
  end
  
  private
	
end
