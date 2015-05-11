class CreateSubjects < ActiveRecord::Migration

  def change
    create_table :subjects do |t|

      t.string :name
      t.timestamps null: false
      t.references :branch_semester_subjects
      
    end
  end

end
