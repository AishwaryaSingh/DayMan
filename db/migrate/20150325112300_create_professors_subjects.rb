class CreateProfessorsSubjects < ActiveRecord::Migration
  def change
    create_table :professors_subjects do |t|
    	t.references :professor
    	t.references :subject 
    end
  end
end
