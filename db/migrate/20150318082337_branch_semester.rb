class BranchSemester < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change
  	create_table :branch_semester do |t|
      t.references :semester, :null => false
      t.references :branch, :null => false
    end
    add_index(:branch_semester, [:semester_id, :branch_id], :unique => true)
  end
end
