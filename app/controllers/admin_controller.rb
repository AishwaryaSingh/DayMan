class AdminController < ApplicationController
	
	def index
	end
	
	def subjects
		@subjects = Subject.all
	end

	def schedules
		@schedule = Schedule.new
	end

	def professors
		@professor = Professor.all
	end

	def units
		@unit = Unit.new
	end
	
	def branches
		@branches = Branch.new
	end
	
	def semesters
		@semesters = Semester.new
	end
	

end
