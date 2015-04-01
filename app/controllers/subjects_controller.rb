class SubjectsController < ApplicationController

	def index
		@subjects = Subject.all
		@branches = Branch.all
	end

	def new
		@subject = Subject.new
	end

	def create
		@subject = Subject.new(subject_params)
		@subject.branches = Branch.find(params[:branch_ids])
		@subject.semesters = Semester.find(params[:semester_ids])
		@subject.save!
		redirect_to subjects_path
	end

	def edit
		@subject = Subject.find(params[:id])
	end

	def update
		@subject = Subject.find(params[:id])
		@subject.branches = Branch.find(params[:branch_ids])
		@subject.semesters = Semester.find(params[:semester_ids])
		@subject.update_attributes(subject_params)
		redirect_to subjects_path
	end

	def destroy
		@subject = Subject.find(params[:id])
		@subject.destroy
		redirect_to subjects_path
	end

	def subject_params
		params.require(:subject).permit(:name, :branch_ids=>[] , :semester_ids=>[] )
	end

	def checked_branches
		@subject.branches = Branch.find(params[:branch_ids[]])
	end

	def checked_semesters
		@subject.semesters = Semester.find(params[:semester_ids])
	end


end
