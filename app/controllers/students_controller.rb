require 'roo'

class StudentsController < ApplicationController

  def import
    if Student.import(params[:file])
      flash[:success] = "Students uploaded"
    else
      flash[:error] = "Some error occured! Please try again!"
    end
    #Student.import(params[:file])
    #redirect_to root_url, notice: "Students imported."
  end

  def index
    @students = Student.all
  end

  def show
    @student = Student.all #find(params[:id])
  end

  def new
    @student = Student.new
  end

  def edit
    @student = Student.find(params[:id])
  end

  def create
    @student = Student.new(student_params)
    

   if @student.valid?
       @student.save
       redirect_to students_path
    else 
      render 'new'
    end
  end

  def update
    @student = Student.find(params[:id])
        
    if @student.valid?
      @student.update_attributes!(student_params)
      redirect_to students_path 
    else
      render 'edit'
    end 
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy   
    redirect_to students_path
  end

  def student_params
    params.require(:student).permit(:name, :batch_id)
  end

end
