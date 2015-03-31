class Subject < ActiveRecord::Base

	#attr_accessible :name, :branch_semester_id

	#belongs_to :semester
	#belongs_to :branch

	has_many :units

	belongs_to :branch_semester

	has_and_belongs_to_many :branches

	has_and_belongs_to_many :semesters


	has_and_belongs_to_many :professors

	belongs_to :schedule

	validates :name , uniqueness: true ,
						presence: true



end
 