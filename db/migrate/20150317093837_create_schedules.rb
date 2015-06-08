class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
        t.string :name
        t.references :branch
        t.references :semester
        t.references :subject
        t.references :batch
        t.references :user
        t.references :room
        t.string :period
        t.datetime :start_date
        t.datetime :end_date 
        t.datetime :starttime
        t.datetime :endtime
        t.timestamps
    end
  end
end