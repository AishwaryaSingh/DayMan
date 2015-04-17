class Subject < ActiveRecord::Base
 
	has_many :units
	has_many :schedules
	has_and_belongs_to_many :branches
	has_and_belongs_to_many :semesters
	has_and_belongs_to_many :professors
	belongs_to :branch_semester


	validates :name , uniqueness: true , presence: true
 	validates :branch_ids , presence: true
  	validates :semester_ids , presence: true

end
 