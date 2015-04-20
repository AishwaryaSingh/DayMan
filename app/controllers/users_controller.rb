class UsersController < ApplicationController
  
  def index
    id=current_user.id
    @user=User.find(id)    
  end

  def show
    if current_user.role.name == "professor"
      @dd=Schedule.find_all_by_user_id(current_user.id)
 #     render json: @dd
    else
      @dd=Schedule.find_all_by_batch_id(current_user.batch_id)
 #     render json: @dd
    end
  #  respond_to do |format|  
#    format.html # index.html.erb  
 #     format.json { render :json => @dd }  
  # end 

  end


  def show3
    puts "I HAVE ENTERED USER#SHOW!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

    @data= Array.new()           #Array = [[title, start.end],[title,start,end]...]
    if current_user.role.name == "professor"
      dd=Schedule.find_all_by_user_id(current_user.id)  
      dd.each do |d|
          title= d.subject.name+" for "+d.batch.name+" in "+d.room.name  #FULCALENDAR TITLE FOR PROFESSOR
          start=d.starttime
          endtime = d.endtime
          arr =Array.new()
          arr=[title,start,endtime]
          @data.push arr
      end
    else
      dd=Schedule.find_all_by_batch_id(current_user.batch_id)
      
      dd.each do |d|
          title= d.subject.name+" by "+d.user.name+" in "+d.room.name  #FULCALENDAR TITLE FOR STUDENT
          start=d.starttime
          endtime = d.endtime
          arr =Array.new()
          arr=[title,start,endtime]
          @data.push arr
          
      end
    end
    render json: @data
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
    puts "I HAVE ENTERED USER#IMPORT_USERS !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"   
  end

  def get_schedules
    puts "I HAVE ENTERED USER#GET_SCHEDULE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
#    @data=Schedule.find_all_by_user_id(current_user.id)
  end

end
