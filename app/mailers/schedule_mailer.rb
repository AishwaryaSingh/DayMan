class ScheduleMailer < ApplicationMailer
  default from: 'TheDayManager@dayman.com'

    def update_email(user,schedule)
		@user = user
		@schedule = schedule
		mail(to: user.email, subject: 'DayMan : There has been a change in your Schedule!')
    end

    def delete_email(user,delete_schedule_array)
		@user = user
		@delete_schedule_array = delete_schedule_array
		mail(to: user.email, subject: 'DayMan : There has been a change in your Schedule!')
  	end

    def create_email(user,create_schedule,day)
		@user = user
		@create_schedule = create_schedule
		@day=day
		mail(to: user.email, subject: 'DayMan : There has been an addition in your Schedule!')
	end
end
