class CreateSubjects < ActiveRecord::Migration

  def change
    create_table :subjects do |t|

      t.string :name
      t.references :branch
      t.references :semester
      t.timestamps null: false
      
    end
  end

end
