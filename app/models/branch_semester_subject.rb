class BranchSemesterSubject < ActiveRecord::Base
	belongs_to :subject
	belongs_to :semester
	belongs_to :branch
end
