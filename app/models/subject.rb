class Subject < ActiveRecord::Base

	belongs_to :semester
	belongs_to :branch

	has_and_belongs_to_many :professors

end
