class Batch < ActiveRecord::Base
  #attr_accessible :name #title, :body

  has_many :schedules
  has_many :users
  belongs_to :branch
  belongs_to :semester

  validates :name, presence: true, uniqueness: true
end
