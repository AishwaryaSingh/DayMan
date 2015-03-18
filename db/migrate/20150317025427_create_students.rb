class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
    	t.string :name
      t.timestamps null: false
    end
    add_column :students , :batch_id , :integer
  end
end
