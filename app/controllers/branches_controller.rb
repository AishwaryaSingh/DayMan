class BranchesController < ApplicationController

  def new
    @branch = Branch.new
    @user = current_user
    @branches = Branch.all
  end

  def edit
    @branches = Branch.all
    @branch = Branch.find(params[:id])
  end

  def create
    @branches = Branch.all
    @branch = Branch.new(unit_params)
     if @branch.valid?
       @branch.save
        redirect_to new_branch_path
      else
        flash[:error]="Branch Can't be Blank!"
      redirect_to new_branch_path
    end
  end

  def update
    @branch = Branch.find(params[:id])
    if @branch.valid?
      if unit_params == ""
        @branch.update_attributes!(unit_params)
        redirect_to new_branch_path
      else
      flash[:error]="Branch Cant't be BLank!"
      render 'edit'
      end
    else
      flash[:error]="Invalid Branch!"
      render 'edit'
    end
  end

  def destroy
    @branches = Branch.find(params[:id])
    @branches.destroy   
    redirect_to new_branch_path
  end

  def unit_params
    params.require(:branch).permit(:name, :id)
  end
end
