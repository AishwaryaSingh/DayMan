require 'iconv'

class User < ActiveRecord::Base

 # after_create :email_to_user
  before_create :set_default_role

  devise :database_authenticatable, :registerable,
         :recoverable,:validatable, :rememberable, :trackable
	
  belongs_to :role
  belongs_to :batch
  has_many :schedules

  #To Upload a Profile Avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  #To check role
  def has_role?(role_sym)
  #roles.any? { |r| r.name.underscore.to_sym == role_sym }
    if r = Role.find_by_id(self.role_id)
      return r.name
    else
      false
    end
  end

  #To create a user
  def self.create(user)
    user.save!
  end

  #To import a file :-
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
  # spreadsheet = Roo::Excelx.new(file.path, nil, :ignore)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = find_by_id(row["id"]) || new
      #user.attributes = row.to_hash.slice(*accessible_attributes)
      user.id = row['id']
      user.name = row['name']
      user.email = row['email']
      user.password = "12345678"
      user.role_id = row['role_id']
      user.batch_id = row['batch_id']
      user.semester_id = row['semester_id']
      user.branch_id = row['branch_id']
      user.sign_up_count = "1"
      user.save!
      UserMailer.welcome_email(user).deliver
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::Csv.new(file.path, packed: nil, file_warning: :ignore)
    when ".xls" then Roo::Excel.new(file.path, packed: nil, file_warning: :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, packed: nil, file_warning: :ignore)
    else 
      raise "Unknown file type: #{file.original_filename}"
    end
  end

  def original_filename
    return File.extname
  end

  private
 
 #Set Default Role as "user"
  def set_default_role
    self.role ||= Role.find_by_name('user')
  end
end
