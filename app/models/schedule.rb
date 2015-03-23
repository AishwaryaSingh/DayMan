class Schedule < ActiveRecord::Base
  # attr_accessible :title, :body

  	belongs_to :classUnit
end
