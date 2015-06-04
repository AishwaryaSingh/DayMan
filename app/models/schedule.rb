class Schedule < ActiveRecord::Base

  	belongs_to :branch
  	belongs_to :semester
  	belongs_to :subject
  	belongs_to :user
  	belongs_to :batch
    belongs_to :room

	  validates :branch_id , presence: true
  	validates :semester_id , presence: true
  	validates :user_id , presence: true
	  validates :subject_id , presence: true
 	  validates :batch_id , presence: true
  	validates :room_id , presence: true

  def self.update_email(schedule , role_id)
    schedule.each do |schedule|
      student_array = User.find_all_by_batch_id_and_branch_id_and_semester_id(schedule.batch_id,schedule.branch_id,schedule.semester_id)
      ScheduleMailer.update_email(student_array,schedule).deliver
    end
    if role_id == 1
      schedule.each do |schedule|
        professor_array = User.find_all_by_id(schedule.user_id)
        ScheduleMailer.update_email(professor_array,schedule).deliver
       end
     end
  end

end
