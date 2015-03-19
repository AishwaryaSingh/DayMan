class CreateYears < ActiveRecord::Migration
  def change
    create_table :years do |t|
    	 t.string :year
    	 t.datetime :SemStartDate
    	 t.datetime :SemEndDate
      t.timestamps
    end
  end
end
