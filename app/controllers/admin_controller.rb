class AdminController < ApplicationController
	def index
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
