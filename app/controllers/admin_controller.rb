class AdminController < ApplicationController
	def index
	end

	def subjects
		@subjects = Subject.all
	end

	def addSchedules
		@schedule = Schedule.new
	end

	def professors
		@professor = Professor.all
	end

	def units
		@unit = Unit.new
	end

end
