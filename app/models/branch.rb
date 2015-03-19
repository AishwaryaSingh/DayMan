class Branch < ActiveRecord::Base

	has_and_belongs_to_many :semesters # , join_table :branch_semester
	
	has_many :subjects
	
end
