 class Semester < ActiveRecord::Base

	#has_and_belongs_to_many :subjects

	#has_many :subjects

	has_many :subjects, :through => :branch_semester_subject
	has_many :branches, :through => :branch_semester_subject

	#has_and_belongs_to_many :branches #, join_table :branch_semester

	has_many :schedules

	
 	validates :name , presence: true ,
 					  uniqueness: true

end
