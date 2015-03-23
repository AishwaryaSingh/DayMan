class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.references  :subject , :integer
      t.references  :batch, :integer
      t.references  :professor , :integer
      t.timestamps
    end
 #   add_column :class_units , :batch_id , :integer
 #   add_column :class_units , :branch_semester_id , :integer
 #   add_column :class_units , :subject_id , :integer
  end
end
