class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|

    	t.datetime :date
    	t.datetime :time
        t.timestamps
    end
    	add_column :schedules , :room_id , :integer
    	add_column :schedules , :year_id , :integer
    	add_column :schedules , :classUnit_id , :integer

  end
end
