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

ActiveRecord::Schema.define(version: 20150908234626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.float    "max_score"
    t.float    "score"
    t.integer  "developer_id"
    t.string   "github_url"
    t.datetime "due_at"
    t.integer  "unit_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "type"
    t.text     "comments"
  end

  add_index "assessments", ["developer_id"], name: "index_assessments_on_developer_id", using: :btree
  add_index "assessments", ["unit_id"], name: "index_assessments_on_unit_id", using: :btree

  create_table "attendances", force: :cascade do |t|
    t.integer  "status",       default: 0
    t.integer  "developer_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "timestamp"
  end

  add_index "attendances", ["developer_id"], name: "index_attendances_on_developer_id", using: :btree
  add_index "attendances", ["status"], name: "index_attendances_on_status", using: :btree

  create_table "cohorts", force: :cascade do |t|
    t.string   "version"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "developers", force: :cascade do |t|
    t.integer  "application_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "phone"
    t.string   "email"
    t.datetime "date_of_birth"
    t.boolean  "veteran"
    t.integer  "personal_device",                   default: 0
    t.boolean  "immigrant"
    t.integer  "education_status",                  default: 0
    t.integer  "current_annual_income"
    t.boolean  "free_or_reduced_lunch"
    t.string   "github_username"
    t.integer  "tshirt_size",                       default: 0
    t.string   "high_school"
    t.integer  "high_school_gpa_cents"
    t.integer  "sat_score"
    t.boolean  "first_generation_college_student"
    t.string   "undergrad_college_or_university"
    t.string   "undergrad_major"
    t.integer  "number_of_undergrad_credits_cents"
    t.integer  "undergrad_gpa_cents"
    t.boolean  "public_or_community_college"
    t.string   "masters_college"
    t.string   "masters_concentration"
    t.integer  "masters_gpa_cents"
    t.string   "degree_currently_pursuing"
    t.string   "current_school"
    t.string   "current_concentration"
    t.integer  "current_gpa_cents"
    t.integer  "current_employment_status",         default: 0
    t.string   "current_employer"
    t.string   "current_job_title"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "gender"
    t.boolean  "borrows_laptop"
    t.string   "race_ethnicity"
    t.string   "online_portfolio_url"
    t.string   "graduate_college_or_university"
    t.string   "graduate_concentration"
    t.integer  "number_of_graduate_credits_cents"
    t.integer  "graduate_gpa_cents"
    t.boolean  "is_current_student"
    t.string   "linkedin_url"
    t.integer  "coding_background",                 default: 0
    t.integer  "cohort_id"
    t.string   "full_name"
  end

  add_index "developers", ["gender"], name: "index_developers_on_gender", using: :btree

  create_table "equipment", force: :cascade do |t|
    t.integer  "type"
    t.string   "description"
    t.string   "reference_id", default: "0"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "equipment", ["reference_id"], name: "index_equipment_on_reference_id", using: :btree

  create_table "exit_tickets", force: :cascade do |t|
    t.integer  "certainty",         default: 0
    t.integer  "quality",           default: 0
    t.integer  "difficulty",        default: 0
    t.integer  "communication",     default: 0
    t.integer  "stimulation",       default: 0
    t.integer  "pace_and_speed",    default: 0
    t.integer  "understanding",     default: 0
    t.integer  "recall",            default: 0
    t.string   "comments"
    t.integer  "developer_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "original_form_url"
    t.datetime "submitted_at"
    t.text     "questions"
    t.float    "score"
    t.string   "summary_form_url"
    t.integer  "type",              default: 0
  end

  create_table "units", force: :cascade do |t|
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "cohort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "index"
  end

  add_index "units", ["cohort_id"], name: "index_units_on_cohort_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "image"
    t.integer  "developer_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
