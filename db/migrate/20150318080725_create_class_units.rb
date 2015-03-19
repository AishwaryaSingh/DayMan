class CreateClassUnits < ActiveRecord::Migration
  def change
    create_table :class_units do |t|

      t.timestamps
    end
    add_column :class_units , :batch_id , :integer
    add_column :class_units , :branch_semester_id , :integer
    add_column :class_units , :subject_id , :integer
  end
end
