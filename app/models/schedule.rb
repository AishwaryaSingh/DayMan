class Schedule < ActiveRecord::Base
  # attr_accessible :title, :body

  	belongs_to :unit
  	belongs_to :branch
  	belongs_to :semester
  	belongs_to :subject
  	belongs_to :professor
  	belongs_to :batch
	
	validates :branch_id , presence: true
  	validates :semester_id , presence: true
  	validates :professor_id , presence: true
	validates :subject_id , presence: true
 	validates :batch_id , presence: true
  	validates :room_id , presence: true


end
