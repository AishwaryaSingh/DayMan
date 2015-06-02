# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create!(:name => "admin")
Role.create!(:name => "professor")
Role.create!(:name => "student")
Role.create!(:name => "user")

User.create!(name: "Admin Test", email: "admin@test.com", password: "aaaaaaaa", role_id: "1")
User.create!(name: "Professor 1 Test", email: "professor1@test.com", password: "aaaaaaaa", role_id: "2")
User.create!(name: "Professor 2 Test", email: "professor2@test.com", password: "aaaaaaaa", role_id: "2")
User.create!(name: "Professor 3 Test", email: "professor3@test.com", password: "aaaaaaaa", role_id: "2")
User.create!(name: "Student CS1 Test", email: "student_cs1@test.com", password: "aaaaaaaa", role_id: "3", batch_id: "1", semester_id: "5", branch_id: "1")
User.create!(name: "Student CS2 Test", email: "student_cs2@test.com", password: "aaaaaaaa", role_id: "3", batch_id: "2", semester_id: "5", branch_id: "1")
User.create!(name: "Student CS3 Test", email: "student_cs3@test.com", password: "aaaaaaaa", role_id: "3", batch_id: "3", semester_id: "5", branch_id: "1")
User.create!(name: "Student CS4 Test", email: "student_cs4@test.com", password: "aaaaaaaa", role_id: "3", batch_id: "3", semester_id: "5", branch_id: "1")
User.create!(name: "Student Mech1 Test", email: "student_mech1@test.com", password: "aaaaaaaa", role_id: "3", batch_id: "1", semester_id: "1", branch_id: "3")
User.create!(name: "Student Mech2 Test", email: "student_mech2@test.com", password: "aaaaaaaa", role_id: "3", batch_id: "2", semester_id: "1", branch_id: "3")
User.create!(name: "Student Mech3 Test", email: "student_mech3@test.com", password: "aaaaaaaa", role_id: "3", batch_id: "3", semester_id: "1", branch_id: "3")

Branch.create!(:name => "CS")
Branch.create!(:name => "IT")
Branch.create!(:name => "Mech")
Branch.create!(:name => "E&TC")
Branch.create!(:name => "Civil")

Semester.create!(:name => "I")
Semester.create!(:name => "II")
Semester.create!(:name => "III")
Semester.create!(:name => "IV")
Semester.create!(:name => "V")
Semester.create!(:name => "VI")
Semester.create!(:name => "VII")
Semester.create!(:name => "VIII")

Batch.create!(:name => "A1")
Batch.create!(:name => "A2")
Batch.create!(:name => "A3")

Room.create!(:name => "F1")
Room.create!(:name => "F2")
Room.create!(:name => "F3")

# habtm by vishal
#Branch.all.each do |a|
#	Semester.all.each { |b| branch.semesters << b }
#end
