class Batch < ActiveRecord::Base
   #attr_accessible :name #title, :body

  has_many :students
   has_many :units

  belongs_to :branch
  belongs_to :semester
  belongs_to :professor
  belongs_to :schedule
  
end
