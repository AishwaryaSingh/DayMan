class Student < ActiveRecord::Base

	has_many :professors
	
	belongs_to :branch
	belongs_to :batch
	belongs_to :subBatch
	belongs_to :semester

end