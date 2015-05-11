class SubjectsController < ApplicationController

	def index
		@subjects = Subject.all
		@bss = BranchSemesterSubject.all
	end

	def new
		@subject = Subject.new
		@bss = BranchSemesterSubject.find_all_by_subject_id(params[:id])
	end

	def create
		#@subject.branches = Branch.find(params[:branch_ids].nil? && [] || params[:branch_ids] )
		#@subject.semesters = Semester.find(params[:semester_ids].nil? && [] || params[:semester_ids])
		
		@subject = Subject.new(subject_params)
		branches=params[:branch_ids]
		semesters=params[:semester_ids]
		if @subject.valid?
			@subject.save!
			branches.each do |b|
				semesters.each do |s|
				@bss=BranchSemesterSubject.new
					@bss.branch_id = b
					@bss.semester_id = s
					@bss.subject_id = @subject.id
					@bss.save!
				end
			end
		end
		redirect_to subjects_path
	end

	def edit
		@subject = Subject.find(params[:id])
		@bss = BranchSemesterSubject.find_all_by_subject_id(params[:id])
	end

	def update
		@subject = Subject.find(params[:id])

		@bss = BranchSemesterSubject.find_all_by_subject_id(params[:id])
		branches=params[:branch_ids]
		semesters=params[:semester_ids]		

		if @subject.valid?
			@subject.update_attributes!(subject_params)

			@bss.each do |b|
				b.destroy
			end
			branches.each do |b|
				semesters.each do |s|
				@bss=BranchSemesterSubject.new
					@bss.branch_id = b
					@bss.semester_id = s
					@bss.subject_id = @subject.id
					@bss.save!
				end
			end

			redirect_to subjects_path
		else
			render 'edit'
		end
	end

	def destroy
		@subject = Subject.find(params[:id])
		@BranchSemesterSubject = BranchSemesterSubject.find_all_by_subject_id(params[:id])
		@BranchSemesterSubject.each do |b|
			b.destroy
		end
		@subject.destroy
		redirect_to subjects_path
	end

	def subject_params
		params.require(:subject).permit(:name,:branch_semester_subject_ids => [])
	end


end
