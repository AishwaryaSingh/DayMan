class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|

      t.string :name
      t.integer :age
      t.string :gender
      t.timestamps null: false
      
    end
  end
end
