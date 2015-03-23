class Professor < ActiveRecord::Base
   #attr_accessible :name , :age , :gender

   has_many :batches
   
   has_and_belongs_to_many :subjects

end
