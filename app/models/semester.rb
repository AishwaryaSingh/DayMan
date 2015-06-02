 class Semester < ActiveRecord::Base

	has_many :branch_semester_subjects
	has_many :subjects, :through => :branch_semester_subject
	has_many :branches, :through => :branch_semester_subject
	has_many :schedules

 	validates :name , presence: true ,
 					  uniqueness: true
end
