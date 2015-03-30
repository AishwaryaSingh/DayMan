class SubjectsController < ApplicationController

	def index
		@subjects = Subject.all
	end

	def new
		@subject = Subject.new
	end

	def create

		puts "In create !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		puts params.inspect 
		puts "In create !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
		@subject = Subject.new(subject_params)
		puts "number of branches -->"+Branch.find(params[:branch_ids]).to_s
		@subject.branches = Branch.find(params[:branch_ids])
		@subject.save!
		redirect_to subjects_path
	end

	def edit
		@subject = Subject.find(params[:id])
	end

	def update
		@subject = Subject.find(params[:id])
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

end
