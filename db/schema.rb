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

ActiveRecord::Schema.define(version: 20140325130431) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["profile_id"], name: "index_accounts_on_profile_id"

  create_table "addresses", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "line_one"
    t.string   "city"
    t.string   "state_region"
    t.string   "zipcode"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_type"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["account_id"], name: "index_groups_on_account_id"

  create_table "identifications", force: true do |t|
    t.string   "foid_type"
    t.string   "foid"
    t.string   "notes"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date_issued"
    t.date     "expiration_date"
    t.string   "issued_by"
    t.string   "country"
    t.string   "sub_type"
    t.string   "max_stay"
    t.date     "entry_date"
  end

  add_index "identifications", ["profile_id"], name: "index_identifications_on_profile_id"

  create_table "members", force: true do |t|
    t.integer  "profile_id"
    t.integer  "group_id"
    t.string   "relationship"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["group_id"], name: "index_members_on_group_id"
  add_index "members", ["profile_id"], name: "index_members_on_profile_id"

  create_table "notes", force: true do |t|
    t.integer  "profile_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["profile_id"], name: "index_notes_on_profile_id"

  create_table "phones", force: true do |t|
    t.string   "phone_type"
    t.string   "number"
    t.integer  "contact_detail_id"
    t.string   "contact_detail_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_versions", force: true do |t|
    t.integer  "profile_id"
    t.integer  "version_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "profile_versions", ["profile_id"], name: "index_profile_versions_on_profile_id"
  add_index "profile_versions", ["version_id"], name: "index_profile_versions_on_version_id"

  create_table "profiles", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.date     "birth_day"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "profile_type"
    t.string   "name"
    t.string   "nationality"
    t.string   "contact_person"
    t.string   "business_type"
    t.string   "client_since"
    t.decimal  "credit_limit"
    t.string   "terms"
    t.string   "status"
    t.string   "lead_source"
    t.string   "marital_status"
    t.string   "occupation"
    t.string   "employer"
    t.string   "job_position"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end
