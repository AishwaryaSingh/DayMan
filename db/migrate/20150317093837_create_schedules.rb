class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
        t.references :branch
        t.references :semester
        t.references  :subject
        t.references  :batch
        t.references  :professor 
    	t.datetime :starttime
    	t.datetime :endtime
    	t.references :day
        t.references :room , :integer       
        t.references :unit , :integer
        t.timestamps
    end
  end
end
