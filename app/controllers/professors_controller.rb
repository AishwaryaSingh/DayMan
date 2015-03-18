class ProfessorsController < ApplicationController

  def index
    @professors = Professor.all
  end

  def show
    @professor = Professor.all #find(params[:id])
  end

  def new
    @professor = Professor.new
  end

  def edit
    @professor = Professor.find(params[:id])
  end

  def create
    @professor = Professor.new(params[:professor])

    @professor.save
    redirect_to professors_path
  end

  def update
    @professor = Professor.find(params[:id])
        
    @professor.update_attributes(params[:professor])
    redirect_to professors_path  
  end

  def destroy
    @professor = Professor.find(params[:id])
    @professor.destroy   
    redirect_to professors_path
  end

end
