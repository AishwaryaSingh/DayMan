class Room < ActiveRecord::Base
  # attr_accessible :title, :body

  	has_many :schedules

 	validates :name , presence: true ,
 					  uniqueness: true
 					  
end
