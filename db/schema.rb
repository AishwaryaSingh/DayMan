# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150401124238) do

  create_table "batches", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branch_semesters", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branches", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "branches_semesters", force: true do |t|
    t.integer "branch_id"
    t.integer "semester_id"
  end

  create_table "branches_subjects", force: true do |t|
    t.integer "subject_id"
    t.integer "branch_id"
  end

  create_table "days", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professors", force: true do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professors_subjects", force: true do |t|
    t.integer "professor_id"
    t.integer "subject_id"
  end

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.integer  "branch_id"
    t.integer  "semester_id"
    t.integer  "subject_id"
    t.integer  "batch_id"
    t.integer  "professor_id"
    t.datetime "starttime"
    t.datetime "endtime"
    t.integer  "day_id"
    t.integer  "room_id"
    t.integer  "integer_id"
    t.integer  "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "semesters", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "semesters_subjects", force: true do |t|
    t.integer "subject_id"
    t.integer "semester_id"
  end

  create_table "students", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "batch_id"
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.integer  "branch_id"
    t.integer  "semester_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "units", force: true do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.integer  "integer_id"
    t.integer  "batch_id"
    t.integer  "professor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "years", force: true do |t|
    t.string   "year"
    t.datetime "SemStartDate"
    t.datetime "SemEndDate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
