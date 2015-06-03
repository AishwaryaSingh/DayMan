class BranchesController < ApplicationController
	
  def index
    @branches = Branch.all
  end

  def show
    @branches = Branch.all
  end

  def new
    @branch = Branch.new
  end

  def edit
    @branch = Branch.find(params[:id])
  end

  def create
    @branch = Branch.new(unit_params)
   
   if @branch.valid?
       @branch.save
       redirect_to branches_path
    else 
      render 'new'
    end 
  end

  def update
    @branch = Branch.find(params[:id])
        
    if @branch.valid?
      @branch.update_attributes!(unit_params)
      redirect_to branches_path 
    else
      render 'edit'
    end 
  end

  def destroy
    @branches = Branch.find(params[:id])
    @branches.destroy   
    redirect_to branches_path
  end


  def unit_params
    params.require(:branch).permit(:name, :id)
  end

end
