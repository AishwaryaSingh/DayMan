class Branch < ActiveRecord::Base

	has_many :semesters
	has_many :professors
	has_many :subjects
	has_many :batches
	has_many :subBatches
	has_many :students

end
