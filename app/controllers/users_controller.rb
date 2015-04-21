class UsersController < ApplicationController
  
  def index
    id=current_user.id
    @user=User.find(id)    
  end

  def show
    if current_user.role.name == "professor"
      @data=Schedule.find_all_by_user_id(current_user.id)
      @data.each do |d|
      d.name= d.subject.name+" for "+d.batch.name+" in "+d.room.name  #FULCALENDAR TITLE FOR PROFESSOR
      d.save!
    end
    else
      @data=Schedule.find_all_by_batch_id(current_user.batch_id)
      @data.each do |d|
          d.name= d.subject.name+" by "+d.user.name+" in "+d.room.name  #FULCALENDAR TITLE FOR STUDENT
          d.save!
      end
    end
    respond_to do |format|  
      format.html # index.html.erb  
      format.json { render :json => @data }  
   end 
  end

  def import
    puts "I HAVE ENTERED USER#IMPORT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"   
    if User.import(params[:file])
      flash[:success] = "Uploaded"
      redirect_to admin_users_path
    else
      flash[:error] = "Some error occured! Please try again!"
    end
  end

  def import_users
  end

  def get_schedules
    puts "I HAVE ENTERED USER#GET_SCHEDULE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
#    @data=Schedule.find_all_by_user_id(current_user.id)
  end

end
