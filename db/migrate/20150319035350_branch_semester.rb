class BranchSemester < ActiveRecord::Migration
  def change
  	create_table :branch_semester, :force => true do |t|
  		t.references :branch
  		t.references :semester
  	end
  end
end
