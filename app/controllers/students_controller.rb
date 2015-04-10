class StudentsController < ApplicationController

  def import
  end

  def index
    @students = Professor.all
  end

  def show
    @student = Professor.all #find(params[:id])
  end

  def new
    @student = Professor.new
  end

  def edit
    @student = Professor.find(params[:id])
  end

  def create
    @student = Professor.new(student_params)
    

   if @student.valid?
       @student.save
       redirect_to students_path
    else 
      render 'new'
    end
  end

  def update
    @student = Professor.find(params[:id])
        
    if @student.valid?
      @student.update_attributes!(student_params)
      redirect_to students_path 
    else
      render 'edit'
    end 
  end

  def destroy
    @student = Professor.find(params[:id])
    @student.destroy   
    redirect_to students_path
  end

  def student_params
    params.require(:student).permit(:name, :age , :gender)
  end

end
