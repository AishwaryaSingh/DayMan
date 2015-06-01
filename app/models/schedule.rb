class Schedule < ActiveRecord::Base
  # attr_accessible :title, :body

  	belongs_to :unit
  	belongs_to :branch
  	belongs_to :semester
  	belongs_to :subject
  	belongs_to :user
  	belongs_to :batch
    belongs_to :room
	
  #  has_many :batches

  #  has_and_belongs_to_many :batches

	  validates :branch_id , presence: true
  	validates :semester_id , presence: true
  	validates :user_id , presence: true
	  validates :subject_id , presence: true
 	  validates :batch_id , presence: true
  	validates :room_id , presence: true

  def self.update_email (schedule)
    student_array = User.find_all_by_batch_id_and_branch_id_and_semester_id(schedule.batch_id,schedule.branch_id,schedule.semester_id)
    ScheduleMailer.update_email(student_array,schedule)
  end

end
