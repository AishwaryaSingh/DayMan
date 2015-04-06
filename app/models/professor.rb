class Professor < ActiveRecord::Base
   #attr_accessible :name , :age , :gender

   has_many :batches
   has_many :units
   has_many :schedules

   has_and_belongs_to_many :subjects

<<<<<<< HEAD
    validates :age , presence: true
=======
    validates :age , presence: true 
>>>>>>> 569a0c52fd4ed047a4607f2ce3d7f4956704d35d
 	validates :name , presence: true ,
 					  uniqueness: true
 	validates :gender , presence: true 

end
