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

end
