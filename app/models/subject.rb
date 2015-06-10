class Subject < ActiveRecord::Base
	has_many :schedules
	has_many :branch_semester_subjects
	has_many :branches, :through => :branch_semester_subject
	has_many :semesters, :through => :branch_semester_subject

	validates :name , uniqueness: true , presence: true

	def self.destroy_and_create_BSS(bss,branches,semesters,subject_id)
		bss.each do |b|
			b.destroy
		end
		branches.each do |b|
			semesters.each do |s|
			bss=BranchSemesterSubject.new
				bss.branch_id = b
				bss.semester_id = s
				bss.subject_id = subject_id
				bss.save!
			end
		end
	end

	def self.create_BSS(bss,branches,semesters,subject_id)
		branches.each do |b|
			semesters.each do |s|
				bss=BranchSemesterSubject.new
				bss.branch_id = b
				bss.semester_id = s
				bss.subject_id = subject_id
				bss.save!
			end
		end
	end
end
 