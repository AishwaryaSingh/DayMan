class CreateBranchSemesterSubjects < ActiveRecord::Migration
  def change
    create_table :branch_semester_subjects do |t|
    	t.references :subject
    	t.references :semester
  		t.references :branch
      t.timestamps
    end

    add_index :branch_semester_subjects, :subject_id
    add_index :branch_semester_subjects, :semester_id
    add_index :branch_semester_subjects, :branch_id
  end
end
