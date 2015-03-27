class SemestersSubjects < ActiveRecord::Migration
  def change
  	create_table :semesters_subjects do |t|
  		t.references :subject
  		t.references :semester
  	end
  end
end
