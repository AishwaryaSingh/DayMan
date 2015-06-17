class AdminController < ApplicationController
	def index
		@user = current_user
	end
	
	def subjects
		@subjects = Subject.all
	end
	
	def branches
		@branches = Branch.new
	end
	
	def semesters
		@semesters = Semester.new
	end
end
