class SemestersController < ApplicationController

  def new
    @semester = Semester.new
    @semesters = Semester.all
    @user = current_user
  end

  def edit
    @semester = Semester.find(params[:id])
    @semesters = Semester.all
  end

  def create
    @semesters = Semester.all
    @semester = Semester.new(unit_params)
    if unit_params == ""
      if @semester.valid? 
         @semester.save
         redirect_to new_semester_path
      end
    else
      flash[:error]="Semester Can't be Blank!"
      render 'new'
    end
  end

  def update
    @semester = Semester.find(params[:id])
    if @semester.valid? 
      if unit_params == ""
        @semester.update_attributes!(unit_params)
        redirect_to new_semester_path
      else
      flash[:error]="Semester Cant't be BLank!"
      render 'edit'
      end
    else
      flash[:error]="Invalid Semester!"
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
