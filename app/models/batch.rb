class Batch < ActiveRecord::Base
   #attr_accessible :name #title, :body

  has_many :units
  has_many :schedules
  has_many :users

#  has_and_belongs_to_many :schedules

  belongs_to :branch
  belongs_to :semester
#  belongs_to :schedule

  
  validates :name , presence: true ,
 					uniqueness: true
  
end
