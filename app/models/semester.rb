class Semester < ActiveRecord::Base

	has_many :subjects
	has_many :batches
	has_many :subBatches
	has_many :students

	belongs_to :branch

end
