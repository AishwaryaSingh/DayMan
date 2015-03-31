class Subject < ActiveRecord::Base

	#attr_accessible :name, :branch_semester_id

	#belongs_to :semester
	#belongs_to :branch

	after_save :update_branch 

	has_many :units

	belongs_to :branch_semester

	has_and_belongs_to_many :branch

	has_and_belongs_to_many :semester


	has_and_belongs_to_many :professors

	belongs_to :schedule

	validates :name , uniqueness: true


	def update_branch
           old_branch_ids = branches_subjects.map(&:branch_id)
           branches_subjects.where(branch_id: old_branch_ids - new_branch_ids).destroy_all
           (new_branch_ids - old_branch_ids).each do |add_branch_id|
           branches_subjects.create!(branch_id: add_branch_id)
    end
end

end
 