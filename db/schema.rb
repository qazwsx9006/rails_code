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

ActiveRecord::Schema.define(version: 20141101074530) do

  create_table "favorites", force: true do |t|
    t.string   "pic"
    t.string   "msg"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", force: true do |t|
    t.string   "pic"
    t.string   "name"
    t.string   "coodinate_x"
    t.string   "coodinate_y"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "account"
    t.string   "password_digest"
    t.string   "nickname"
    t.string   "mimi_t"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mood"
    t.string   "about"
    t.string   "info_bg"
    t.datetime "mood_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
