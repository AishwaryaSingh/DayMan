class Subject < ActiveRecord::Base

	has_many :professors
	has_many :lectures
	
	belongs_to :branch
	belongs_to :batch
	belongs_to :subBatch
	belongs_to :semester

end
