class UnitsController < ApplicationController

  def index
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
    @unit = Unit.new(params[:classUnits])

    @unit.save
    redirect_to units_path
  end

  def update
    @unit = Unit.find(params[:id])
        
    @unit.update_attributes(params[:classUnits])
    redirect_to units_path  
  end

  def destroy
    @units = Unit.find(params[:id])
    @units.destroy   
    redirect_to units_path
  end

end
