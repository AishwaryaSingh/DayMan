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
		@subject.branches = Branch.find(params[:branch_ids].nil? && [] || params[:branch_ids] )
		@subject.semesters = Semester.find(params[:semester_ids].nil? && [] || params[:semester_ids])
		
		if @subject.valid?
		   @subject.save
		   redirect_to subjects_path
		else 
			render 'new'
		end	

	end

	def edit
		@subject = Subject.find(params[:id])
	end

	def update
		@subject = Subject.find(params[:id])
		@subject.branches = Branch.find(params[:branch_ids].nil? && [] || params[:branch_ids] )
		@subject.semesters = Semester.find(params[:semester_ids].nil? && [] || params[:semester_ids])
		if @subject.update_attributes!(subject_params)
			redirect_to subjects_path
		else
			flash[:notice] = "Please fill all parameters"
		end

	end

	def destroy
		@subject = Subject.find(params[:id])
		@subject.destroy
		redirect_to subjects_path
	end

	def subject_params
		params.require(:subject).permit(:name, :branch_ids=>[] , :semester_ids=>[] )
	end


end
