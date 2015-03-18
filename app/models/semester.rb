class Semester < ActiveRecord::Base

	has_many :subjects

	belongs_to :branch, join_table :branch_semester

end
