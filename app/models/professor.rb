require 'iconv'
#require 'csv'
#require 'roo'

class Professor < ActiveRecord::Base
   #attr_accessible :name , :age , :gender

   has_many :batches
   has_many :units
   has_many :schedules

   belongs_to :user

   has_and_belongs_to_many :subjects


    validates :age , presence: true


 	validates :name , presence: true ,
 					  uniqueness: true
 	validates :gender , presence: true 



 	def self.import(file)
	     spreadsheet = Roo::Excelx.new(file.path, nil, :ignore)
		  header = spreadsheet.row(1)
		  (2..spreadsheet.last_row).each do |i|
		    row = Hash[[header, spreadsheet.row(i)].transpose]
		    professor = find_by_id(row["id"]) || new
		    #professor.attributes = row.to_hash.slice(*accessible_attributes)
		    professor.name = row['name']
		    professor.age = row['age']
		    professor.gender = row['gender']
		    professor.save!
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
