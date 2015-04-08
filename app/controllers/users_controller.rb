class UsersController < ApplicationController


  def login
    
  end

  def register
    
  end

	def index
#		    @sent_messages = current_user.sent_messages.all
	end

  private

  def ensure_admin!
    unless current_user.admin?
      sign_out current_user

      redirect_to root_path

      return false
    end
  end

end
