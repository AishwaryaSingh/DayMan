class SubjectsController < ApplicationController

	def index
		@subjects = Subject.all
		@branches = Branch.all
	end

	def new
		@subject = Subject.new
	end

	def create
		#@subject.branches = Branch.find(params[:branch_ids].nil? && [] || params[:branch_ids] )
		#@subject.semesters = Semester.find(params[:semester_ids].nil? && [] || params[:semester_ids])
		#
		branches=params[:branch_ids]
		semesters=params[:semester_ids]

		@subject = Subject.new(subject_params)
		
		if @subject.valid?

			@subject.save!

			branches.each do |b|
				@bss=BranchSemesterSubject.new
				semesters.each do |s|
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
	end

	def update
		@subject = Subject.find(params[:id])
		@subject.branches = Branch.find(params[:branch_ids].nil? && [] || params[:branch_ids] )
		@subject.semesters = Semester.find(params[:semester_ids].nil? && [] || params[:semester_ids])
		
		if @subject.valid?
			@subject.update_attributes!(subject_params)
			redirect_to subjects_path
		else
			render 'edit'
		end

	end

	def destroy
		@subject = Subject.find(params[:id])
		@subject.destroy
		redirect_to subjects_path
	end

	def subject_params
		params.require(:subject).permit(:name)
	end


end
