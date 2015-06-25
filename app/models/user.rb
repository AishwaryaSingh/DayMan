require 'iconv'

class User < ActiveRecord::Base

 # after_create :email_to_user
  before_create :set_default_role

  devise :database_authenticatable, :registerable,:recoverable,:validatable, :rememberable, :trackable ,:timeoutable

  belongs_to :role
  belongs_to :batch
  has_many :schedules

  #To Upload a Profile Avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :email, :presence => true
  
  def self.save_event_to_display(current_user)
    if current_user.role.name == "professor"
      data=Schedule.find_all_by_user_id(current_user.id)
      data.each do |d|
        d.name= d.subject.name+" for "+d.batch.name+" in "+d.room.name  #FULCALENDAR TITLE FOR PROFESSOR
        d.save!
      end
    elsif current_user.role.name == "student_professor"
      data=Schedule.find_all_by_batch_id_and_semester_id_and_branch_id(current_user.batch_id,current_user.semester_id,current_user.branch_id)
      data.each do |d|
        d.name= d.subject.name+" by "+d.user.name+" in "+d.room.name  #FULCALENDAR TITLE FOR STUDENT
        d.save!
      end
      professor_data=Schedule.find_all_by_user_id(current_user.id)
      professor_data.each do |d|
        d.name= d.subject.name+" for "+d.batch.name+" in "+d.room.name  #FULCALENDAR TITLE FOR PROFESSOR
        d.save!
        data.append(d);
      end
    else
      data=Schedule.find_all_by_batch_id_and_semester_id_and_branch_id(current_user.batch_id,current_user.semester_id,current_user.branch_id)
      data.each do |d|
        d.name= d.subject.name+" by "+d.user.name+" in "+d.room.name  #FULCALENDAR TITLE FOR STUDENT
        d.save!
      end
    end
    return data
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
    $error_array = []
    $error_count = 0
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
      if !user.email.nil? && !user.name.nil?
        if EmailVerifier.check(user.email)
          if user.valid?
            if user.role_id<=3
                        if User.exists?(user.id)
                          if user.email == User.find(user.id).email && user.name == User.find(user.id).name
                            if user.email == User.find(user.id).email
                              user.save!
                              if user.email != User.find(user.id).email && user.name != User.find(user.id).name
                              end
                            else
                              $error_array.append([i, "Email Address Can NOT Be Changed!"])
                              $error_count = $error_count + 1
                            end
                          else
                            $error_array.append([i, "ID Taken- Please assign a new ID!"])
                            $error_count = $error_count + 1
                          end
                        else
                          user.save!
                          UserMailer.welcome_email(user).deliver
                        end
            else
              $error_array.append([i, "Role_id Can not Be Empty!"])
              $error_count = $error_count + 1
            end

          end
        else
          $error_array.append([i, "Invalid Email Address!"])
          $error_count = $error_count + 1
        end
      else
        if !user.email?
          $error_array.append([i, "Email Can NOT Be Empty/NULL!"])
          $error_count = $error_count + 1
        else
          $error_array.append([i, "Name Can NOT Be Empty/NULL!"])
          $error_count = $error_count + 1
        end
      end
    end
    if $error_count > 0
      return false
    else
      return true
    end
  end

  def self.get_errors
    return $error_array
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
