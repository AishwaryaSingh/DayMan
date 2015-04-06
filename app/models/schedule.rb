class Schedule < ActiveRecord::Base
  # attr_accessible :title, :body

  	belongs_to :unit
  	belongs_to :branch
  	belongs_to :semester
  	belongs_to :subject
  	belongs_to :professor
  	belongs_to :batch

  	

end
