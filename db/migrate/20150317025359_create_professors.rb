class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|

      t.string :name
      t.string :email

      t.integer :age
      t.string :gender

      t.references :role
      t.timestamps null: false
      
    end
  end
end
