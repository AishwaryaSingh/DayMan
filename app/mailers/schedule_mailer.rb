class ScheduleMailer < ApplicationMailer
  default from: 'TheDayManager@dayman.com'

  def update_email(user,schedule)
		@user = user
		@schedule = schedule
		mail(to: user.email, subject: 'DayMan : There has been a change in your Schedule!')
  end

    def delete_email(student_array,schedule)
  	student_array.each do |user|
	    @user = user
	    @schedule = schedule
	    mail(to: user.email, subject: 'DayMan : There has been a change in your Schedule!')
	  end
  end
end
