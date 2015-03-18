class CreateJoinTableOfBranchAndSemester < ActiveRecord::Migration
  def up
  end

  def down
  end

  def change
  	create_join_table :branch_semester do |t|
  		t.reference :branch_semester , :branch_id , :integer
  		t.intger :branch_semester , :semester_id , :integer
  		t.timestamps 
  	end
  end
end
