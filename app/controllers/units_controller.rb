class UnitsController < ApplicationController

  def index
    @units = Unit.all
  end

  def show
    @units = Unit.all  #find(params[:id])
  end

  def new
    @unit = Unit.new
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def create
    @unit = Unit.new(unit_params)

    @unit.save
    redirect_to units_path
  end

  def update
    @unit = Unit.find(params[:id])
        
    @unit.update_attributes(unit_params)
    redirect_to units_path  
  end

  def destroy
    @units = Unit.find(params[:id])
    @units.destroy   
    redirect_to units_path
  end


  def unit_params
    params.require(:unit).permit(:name, :id, :subject_id, :professor_id , :batch_id)
  end


end
