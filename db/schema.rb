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

ActiveRecord::Schema.define(version: 20140129191336) do

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

  create_table "phones", force: true do |t|
    t.string   "phone_type"
    t.string   "number"
    t.integer  "contact_detail_id"
    t.string   "contact_detail_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
  end

end
