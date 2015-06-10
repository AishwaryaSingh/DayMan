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

    add_index :schedules, :branch_id
    add_index :schedules, :semester_id
    add_index :schedules, :subject_id
    add_index :schedules, :batch_id
    add_index :schedules, :user_id
    add_index :schedules, :room_id
  end
end