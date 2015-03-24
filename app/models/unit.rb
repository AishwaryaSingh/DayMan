class Unit < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :schedules

  belongs_to :professor
  belongs_to :batch
  belongs_to :subject
  
end

