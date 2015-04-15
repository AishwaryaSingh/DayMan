require 'iconv'
#require 'csv'
#require 'roo'

class Professor < ActiveRecord::Base
   #attr_accessible :name , :age , :gender

   has_many :batches
   has_many :units
   has_many :schedules

   belongs_to :user

   has_and_belongs_to_many :subjects



   validates :age , presence: true


   validates :name , presence: true ,
 					 uniqueness: true

   validates :gender , presence: true 


end
