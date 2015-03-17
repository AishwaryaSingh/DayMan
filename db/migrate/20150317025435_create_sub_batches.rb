class CreateSubBatches < ActiveRecord::Migration
  def change
    create_table :sub_batches do |t|

      t.timestamps null: false
    end
  end
end
