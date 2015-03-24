class Schedule < ActiveRecord::Base
  # attr_accessible :title, :body

  	belongs_to :unit
  	belongs_to :schedule

  	has_many :subjects
  	has_many :professors
  	has_many :batches

end
