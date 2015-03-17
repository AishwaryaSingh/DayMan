class SubBatch < ActiveRecord::Base

	has_many :students
	has_many :subjects
	has_many :lectures

	belongs_to :batch

end
