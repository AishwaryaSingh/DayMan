class BranchSemesterSubject < ActiveRecord::Base
	
	belongs_to :subject
	belongs_to :semester
	belongs_to :branch

	validates :branch_id , presence: true
 	validates :semester_id , presence: true
end
