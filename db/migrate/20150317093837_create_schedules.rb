class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|

    	t.datetime :starttime
    	t.datetime :endtime
        t.references :subject , :integer
        t.references :room , :integer
        t.references :year , :integer
        t.references :batch , :integer
        t.references :professor , :integer        
        t.references :unit , :integer
        t.timestamps
    end
  end
end
