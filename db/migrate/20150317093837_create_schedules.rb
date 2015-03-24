class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|

    	t.datetime :starttime
    	t.datetime :endtime
        t.references :room , :integer       
        t.references :unit , :integer
        t.timestamps
    end
  end
end
