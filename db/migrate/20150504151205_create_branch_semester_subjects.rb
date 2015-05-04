class CreateBranchSemesterSubjects < ActiveRecord::Migration
  def change
    create_table :branch_semester_subjects do |t|
    	t.references :subject
    	t.references :semester
  		t.references :branch
      t.timestamps
    end
  end
end
