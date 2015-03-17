class Batch < ActiveRecord::Migration
  def change
  	  create_table :batches do |t|

    	 t.string :name

      t.timestamps null: false
  end
end
