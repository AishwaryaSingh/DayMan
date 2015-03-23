class CreateBranchSemesters < ActiveRecord::Migration
  def change
    create_table :branch_semesters do |t|

      t.string :name
      t.timestamps
    end
  end
end
