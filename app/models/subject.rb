class Subject < ActiveRecord::Base
 
	has_many :units
	has_many :schedules
	has_and_belongs_to_many :professors
	belongs_to :branch_semester

	#has_and_belongs_to_many :branches
	#has_and_belongs_to_many :semesters
	has_many :branch_semester_subjects
	has_many :branches, :through => :branch_semester_subject
	has_many :semesters, :through => :branch_semester_subject
#   belongs_to :branch
#   belongs_to :semester

	validates :name , uniqueness: true , presence: true
# 	validates :branch_ids , presence: true
# 	validates :semester_ids , presence: true

end
 