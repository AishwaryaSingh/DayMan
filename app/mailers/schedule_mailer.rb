class ScheduleMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def update_email(student_array,schedule)
  	student_array.each do |user|
	    @user = user
	    @schedule = schedule
	    mail(to: user.email, subject: 'DayMan : There has been a change in your Schedule!')
	  end
  end

    def delete_email(student_array,schedule)
  	student_array.each do |user|
	    @user = user
	    @schedule = schedule
	    mail(to: user.email, subject: 'DayMan : There has been a change in your Schedule!')
	  end
  end
end
