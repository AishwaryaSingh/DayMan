class Professor < ActiveRecord::Base

	has_many :subjects
	has_many :batches
	has_many :subBatches
	has_many :lectures

	belongs_to :branch

end
