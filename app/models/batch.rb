class Batch < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :students

  belongs_to :branch
  belongs_to :semester
  belongs_to :professor
  
end
