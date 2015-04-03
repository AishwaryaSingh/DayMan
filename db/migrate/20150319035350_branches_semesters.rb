class BranchesSemesters < ActiveRecord::Migration
  def change
  	create_table :branches_semesters, :force => true do |t|
  		t.references :branch
  		t.references :semester
  	end
  end
end
