class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|

<<<<<<< HEAD
       t.string :name
       	
=======
      t.string :name
      t.integer :age
      t.string :gender
      
>>>>>>> df9e679ffc8ac0c59eea782ed4d83d047b93ec45
      t.timestamps null: false
    end
  end
end
