
#require 'role_model'

class User < ActiveRecord::Base
  
  #before_save :setup_role
  #before_create :set_default_role

  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
#	include RoleModel

	# Setup accessible (or protected) attributes for your model
  	#attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :roles_mask
 
  	# optionally set the integer attribute to store the roles in,
  	# :roles_mask is the default
#  	roles_attribute :roles_mask
 
  	# declare the valid roles -- do not change the order if you add more
  	# roles later, always append them at the end!

# 	roles :admin, :professor, :student

	has_and_belongs_to_many :roles
	has_many :professors
	has_many :students
#	has_many :admins

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end
    def setup_role 
    if self.role_ids.empty?     
      self.role_ids = [2] 
    end
  end

  private
  
  def set_default_role
    self.role ||= Role.find_by_name('student')
  end

end
