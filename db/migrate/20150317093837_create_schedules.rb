class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
        t.references :branch
        t.references :semester
        t.references :subject
        t.references :batch
        t.references :professor
#    	t.references :day
        t.references :room   
#       t.references :unit
        t.timestamps
        t.datetime :starttime
        t.datetime :endtime

    end
  end
end