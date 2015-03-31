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

ActiveRecord::Schema.define(version: 20150317222453) do

  create_table "assignment_types", force: :cascade do |t|
    t.string   "assign_type"
    t.float    "percentage"
    t.integer  "course_id"
    t.string   "format"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "assignment_types", ["course_id"], name: "index_assignment_types_on_course_id"

  create_table "assignments", force: :cascade do |t|
    t.string   "name"
    t.datetime "assigned"
    t.datetime "due"
    t.integer  "course_id"
    t.string   "assign_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "assignments", ["course_id"], name: "index_assignments_on_course_id"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "courses", ["user_id"], name: "index_courses_on_user_id"

  create_table "grades", force: :cascade do |t|
    t.float    "score"
    t.integer  "student_id"
    t.integer  "assignment_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "grades", ["assignment_id"], name: "index_grades_on_assignment_id"
  add_index "grades", ["student_id"], name: "index_grades_on_student_id"

  create_table "notes", force: :cascade do |t|
    t.integer  "notable_id"
    t.string   "notable_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "notes", ["notable_id"], name: "index_notes_on_notable_id"

  create_table "students", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.integer  "absences"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "students", ["course_id"], name: "index_students_on_course_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
