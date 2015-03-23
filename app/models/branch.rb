class Branch < ActiveRecord::Base
  
    after_save :update_branch_semester

	has_and_belongs_to_many :semesters # , join_table :branch_semester
	
	has_many :subjects
	


	private 

	def update_branch_semester
		Semester.all.each { |b| self.semester << b }
	end


end
