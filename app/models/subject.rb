class Subject < ActiveRecord::Base
 
	has_many :schedules
	has_many :branch_semester_subjects
	has_many :branches, :through => :branch_semester_subject
	has_many :semesters, :through => :branch_semester_subject

	validates :name , uniqueness: true , presence: true
end
 