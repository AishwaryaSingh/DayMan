class ScheduleMailer < ApplicationMailer
  default from: 'TheDayManager@dayman.com'

    def update_email(user,schedule)
		@user = user
		@schedule = schedule
		mail(to: user.email, subject: 'DayMan : There has been a change in your Schedule!')
    end

    def delete_email(user,schedule)
		@user = user
		@schedule = schedule
		mail(to: user.email, subject: 'DayMan : There has been a change in your Schedule!')
  	end

    def create_email(user,schedule,day)
		@user = user
		@schedule = schedule
		@day=day
		mail(to: user.email, subject: 'DayMan : There has been an addition in your Schedule!')
	end
end
