 class Branch < ActiveRecord::Base
   #serialize :branch_id, Array  ## Add this line
   #after_save :update_branch_semester

	has_and_belongs_to_many :semesters # , join_table :branch_semester
	
	has_and_belongs_to_many :subjects

   #has_many :subjects

   has_many :schedules
 	

 	validates :name , presence: true ,
 					  uniqueness: true


#	private 
#   def name_with_initial
#    branch.name
#   end
#	def update_branch_semester
#		Semester.all.each { |b| self.semester << b }
#	end

end
