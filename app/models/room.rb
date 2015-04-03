class Room < ActiveRecord::Base
  # attr_accessible :title, :body


 	validates :name , presence: true ,
 					  uniqueness: true
 					  
end
