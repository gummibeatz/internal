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

ActiveRecord::Schema.define(version: 20150729215542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "addresses", ["contact_id"], name: "index_addresses_on_contact_id", using: :btree

  create_table "developers", force: :cascade do |t|
    t.integer  "application_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.string   "phone"
    t.string   "email"
    t.datetime "date_of_birth"
    t.boolean  "veteran"
    t.integer  "personal_device",                  default: 0
    t.boolean  "immigrant"
    t.integer  "education_status",                 default: 0
    t.integer  "current_annual_income"
    t.boolean  "free_or_reduced_lunch"
    t.string   "github_username"
    t.integer  "tshirt_size",                      default: 0
    t.string   "high_school"
    t.integer  "high_school_gpa_cents"
    t.integer  "sat_score"
    t.boolean  "first_generation_college_student"
    t.string   "college_or_university"
    t.string   "college_major"
    t.integer  "number_of_college_credits_cents"
    t.integer  "college_gpa_cents"
    t.boolean  "public_or_community_college"
    t.string   "masters_college"
    t.string   "masters_concentration"
    t.integer  "masters_gpa_cents"
    t.string   "degree_currently_pursuing"
    t.string   "current_school"
    t.string   "current_concentration"
    t.integer  "current_gpa_cents"
    t.integer  "current_employment_status",        default: 0
    t.string   "current_employer"
    t.string   "current_job_title"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "gender"
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
