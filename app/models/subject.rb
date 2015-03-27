class Subject < ActiveRecord::Base

	#attr_accessible :name, :branch_semester_id

	#belongs_to :semester
	#belongs_to :branch

	has_many :units

	belongs_to :branch_semester

	has_and_belongs_to_many :branch

	has_and_belongs_to_many :semester


	has_and_belongs_to_many :professors

	belongs_to :schedule

	validates :name , uniqueness: true

end
 