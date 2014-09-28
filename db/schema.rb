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

ActiveRecord::Schema.define(version: 20140928034900) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "messages", force: true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "acknowledged_at"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "facebook_id"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "birthday"
    t.string   "facebook_token"
    t.datetime "facebook_token_expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["facebook_id"], name: "index_users_on_facebook_id", unique: true, using: :btree

end
