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
Role.create!(:name => "student_professor")
Role.create!(:name => "user")

User.create!(name: "Admin Test", email: "admin@test.com", password: "aaaaaaaa", role_id: "1")
User.create!(name: "Shruti Patil", email: "shruti.patil@sitpune.edu.in", password: "aaaaaaaa", role_id: "2")
User.create!(name: "Kalyani Kadam", email: "kalyanik@sitpune.edu.in", password: "aaaaaaaa", role_id: "2")
User.create!(name: "Praveen Gubbala", email: "praveeng@sitpune.edu.in", password: "aaaaaaaa", role_id: "2")
User.create!(name: "Raj Kalpesh Shah", email: "raj.shah@sitpune.edu.in", password: "aaaaaaaa", role_id: "3", batch_id: "1", semester_id: "1", branch_id: "3")
User.create!(name: "Manish Sharma", email: "manish.sharma@sitpune.edu.in", password: "aaaaaaaa", role_id: "3", batch_id: "3", semester_id: "1", branch_id: "3")
#User.create!(name: "Aishwarya Singh", email: "aishwarya.singh@sitpune.edu.in", password: "aaaaaaaa", role_id: "3", batch_id: "1", semester_id: "5", branch_id: "1")
User.create!(name: "Aman Bhatia", email: "aman.bhatia@sitpune.edu.in", password: "aaaaaaaa", role_id: "3", batch_id: "2", semester_id: "5", branch_id: "1")
User.create!(name: "Akshita Pradhan", email: "akshita.pradhan@sitpune.edu.in", password: "aaaaaaaa", role_id: "3", batch_id: "3", semester_id: "5", branch_id: "1")

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

Room.create!(:name => "G1")
Room.create!(:name => "G2")
Room.create!(:name => "G3")
Room.create!(:name => "G4")
Room.create!(:name => "G5")
Room.create!(:name => "G6")
Room.create!(:name => "F1")
Room.create!(:name => "F2")
Room.create!(:name => "F3")
Room.create!(:name => "S1")
Room.create!(:name => "S2")
Room.create!(:name => "S3")
Room.create!(:name => "S4")
Room.create!(:name => "S5")
Room.create!(:name => "S6")
Room.create!(:name => "T1")
Room.create!(:name => "T2")
Room.create!(:name => "T3")

