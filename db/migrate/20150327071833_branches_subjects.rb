class BranchesSubjects < ActiveRecord::Migration
  def change
  	create_table :branches_subjects do |t|
  		t.references :subject
  		t.references :branch
  	end
  end
end
