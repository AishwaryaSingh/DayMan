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

ActiveRecord::Schema.define(version: 20150504151205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "batches", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branch_semester_subjects", force: true do |t|
    t.integer  "subject_id"
    t.integer  "semester_id"
    t.integer  "branch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branch_semester_subjects", ["branch_id"], name: "index_branch_semester_subjects_on_branch_id", using: :btree
  add_index "branch_semester_subjects", ["semester_id"], name: "index_branch_semester_subjects_on_semester_id", using: :btree
  add_index "branch_semester_subjects", ["subject_id"], name: "index_branch_semester_subjects_on_subject_id", using: :btree

  create_table "branches", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", unique: true, using: :btree

  create_table "rooms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.string   "name"
    t.integer  "branch_id"
    t.integer  "semester_id"
    t.integer  "subject_id"
    t.integer  "batch_id"
    t.integer  "user_id"
    t.integer  "room_id"
    t.string   "period"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "starttime"
    t.datetime "endtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["batch_id"], name: "index_schedules_on_batch_id", using: :btree
  add_index "schedules", ["branch_id"], name: "index_schedules_on_branch_id", using: :btree
  add_index "schedules", ["room_id"], name: "index_schedules_on_room_id", using: :btree
  add_index "schedules", ["semester_id"], name: "index_schedules_on_semester_id", using: :btree
  add_index "schedules", ["subject_id"], name: "index_schedules_on_subject_id", using: :btree
  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id", using: :btree

  create_table "semesters", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.string   "user_name"
    t.string   "provider"
    t.string   "uid"
    t.integer  "role_id"
    t.integer  "sign_up_count"
    t.integer  "batch_id"
    t.integer  "semester_id"
    t.integer  "branch_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["batch_id"], name: "index_users_on_batch_id", using: :btree
  add_index "users", ["branch_id"], name: "index_users_on_branch_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree
  add_index "users", ["semester_id"], name: "index_users_on_semester_id", using: :btree

end
