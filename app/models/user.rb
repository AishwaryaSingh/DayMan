require 'iconv'

class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
  belongs_to :role
	has_many :professors
	has_many :students

#To check role

  def has_role?(role_sym)
#   roles.any? { |r| r.name.underscore.to_sym == role_sym }
    if r = Role.find_by_id(self.role_id)
      return r.name
    else
      false
    end
  end

#To import a file :-

  def self.import_users(file)
    spreadsheet = Roo::Excelx.new(file.path, nil, :ignore)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
     user= new
      user.attributes = row.to_hash
      user.save!
    end
  end

  def self.import(file)
      spreadsheet = Roo::Excelx.new(file.path, nil, :ignore)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        student = find_by_id(row["id"]) || new
        #student.attributes = row.to_hash.slice(*accessible_attributes)
        user.name = row['name']
        user.email = row['email']
        user.encrypted_password = "123"
        user.role = row['role']
        user.save!
      end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then CSV.new(file.path)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else 
      raise "Unknown file type: #{file.original_filename}"
    end
  end

  def original_filename
    return File.extname
  end

end
