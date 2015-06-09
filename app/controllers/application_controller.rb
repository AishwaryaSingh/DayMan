class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
    before_filter :authenticate_user!
    before_filter :configure_permitted_parameters, if: :devise_controller?

    def has_role?(role_sym)
   		roles.any? { |r| r.name.underscore.to_sym == role_sym }
    end

	rescue_from CanCan::AccessDenied do |exception|
    	redirect_to root_url, :alert => exception.message
  	end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :user_name, :role_id, :avatar , :batch_id, :branch_id , :semester_id) }
    end

end
