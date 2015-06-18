class UserMailer < ApplicationMailer
  default from: 'TheDayManager@dayman.com'

  def welcome_email(user)
    @user = user
    @url  = 'https://guarded-taiga-6031.herokuapp.com'
    mail(to: user.email, subject: 'Welcome to Day Manager!')
  end
end
