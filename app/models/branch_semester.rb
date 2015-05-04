class BranchSemester < ActiveRecord::Base
	
   	has_many :subjects


 	validates :name , presence: true ,
 					  uniqueness: true
 					  
end
