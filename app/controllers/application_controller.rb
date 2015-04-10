class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
    before_filter :authenticate_user!

    def has_role?(role_sym)
   		roles.any? { |r| r.name.underscore.to_sym == role_sym }
    end

	rescue_from CanCan::AccessDenied do |exception|
    	redirect_to root_url, :alert => exception.message
  	end

end
