require 'iconv'
#require 'csv'
#require 'roo'

class Student < ActiveRecord::Base

    belongs_to :user
	belongs_to :batch


	#Import student list

	def self.import(file)
	     spreadsheet = Roo::Excelx.new(file.path, nil, :ignore)
		  header = spreadsheet.row(1)
		  (2..spreadsheet.last_row).each do |i|
		    row = Hash[[header, spreadsheet.row(i)].transpose]
		    student = find_by_id(row["id"]) || new
		    #student.attributes = row.to_hash.slice(*accessible_attributes)
		    student.name = row['name']
		    student.email = row['email']
		    student.batch_id = row['batch_id']
            student.role_id = "3"
		    student.save!
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