class Lecture < ActiveRecord::Base

	belongs_to :professor
	belongs_to :subject
	belongs_to :batch
	belongs_to :subBatch
	
end
