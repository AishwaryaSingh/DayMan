class Branch < ActiveRecord::Base

	has_many :semesters , join_table :branch_semester
	has_many :subjects
	
end
