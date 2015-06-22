class SemestersController < ApplicationController
  def index
    @semesters = Semester.all
  end

  def show
    @semesters = Semester.all
  end

  def new
    @semester = Semester.new
    @semesters = Semester.all
    @user = current_user
  end

  def edit
    @semester = Semester.find(params[:id])
  end

  def create
    @semester = Semester.new(unit_params)
    if @semester.valid?
       @semester.save
       redirect_to new_semester_path
    else
      render 'new'
    end
  end

  def update
    @semester = Semester.find(params[:id])
    if @semester.valid?
      @semester.update_attributes!(unit_params)
      redirect_to new_semester_path
    else
      render 'edit'
    end 
  end

  def destroy
    @semester = Semester.find(params[:id])
    @semester.destroy   
    redirect_to new_semester_path
  end

  def unit_params
    params.require(:semester).permit(:name, :id)
  end
end
