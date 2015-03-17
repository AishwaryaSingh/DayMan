class Batch < ActiveRecord::Base

	has_many :subBatches
	has_many :students
	has_many :subjects
	has_many :professors
	has_many :lectures

	belongs_to :semester
	belongs_to :branch

end
