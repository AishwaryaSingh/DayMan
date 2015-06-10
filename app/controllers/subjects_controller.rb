class SubjectsController < ApplicationController

	def index
		@subjects = Subject.all
		@bss = BranchSemesterSubject.all
		@branch = Branch.all
		@semester = Semester.all
	end

	def new
		@subject = Subject.new
		@count = true
	end

	def create
		@subject = Subject.new(subject_params)
		@bss=BranchSemesterSubject.new
		branches=params[:branch_ids]
		semesters=params[:semester_ids]
		if !params[:branch_ids] || !params[:semester_ids]
			render 'new'
			flash[:error] = "Incomplete Information!!"
		else
			if @subject.valid?
				@subject.save!
				Subject.create_BSS(@bss,branches,semesters,@subject.id)
				redirect_to subjects_path
			else
				render 'new'
				flash[:error] = "Incomplete Information!!"
			end
		end
	end

	def edit
		@subject = Subject.find(params[:id])
		@bss = BranchSemesterSubject.find_all_by_subject_id(params[:id])
		@count = false
	end

	def update
		@subject = Subject.find(params[:id])
		@bss = BranchSemesterSubject.find_all_by_subject_id(params[:id])
		branches=params[:branch_ids]
		semesters=params[:semester_ids]		
		if @subject.valid?
			@subject.update_attributes!(subject_params)
			Subject.destroy_and_create_BSS(@bss,branches,semesters,@subject.id)
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
