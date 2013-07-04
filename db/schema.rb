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

ActiveRecord::Schema.define(version: 20130703122108) do

  create_table "expenses", force: true do |t|
    t.string   "name"
    t.integer  "cost"
    t.integer  "tag_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date"
    t.integer  "group_id"
    t.integer  "user_id"
  end

  add_index "expenses", ["group_id"], name: "index_expenses_on_group_id"
  add_index "expenses", ["slug"], name: "index_expenses_on_slug"
  add_index "expenses", ["user_id"], name: "index_expenses_on_user_id"

  create_table "group_tags", force: true do |t|
    t.integer  "group_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_tags", ["group_id"], name: "index_group_tags_on_group_id"
  add_index "group_tags", ["tag_id"], name: "index_group_tags_on_tag_id"

  create_table "group_users", force: true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role"
    t.string   "state"
  end

  add_index "group_users", ["group_id"], name: "index_group_users_on_group_id"
  add_index "group_users", ["user_id"], name: "index_group_users_on_user_id"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.text     "description", limit: 255
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  add_index "groups", ["slug"], name: "index_groups_on_slug"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_default"
  end

  add_index "tags", ["slug"], name: "index_tags_on_slug"

  create_table "users", force: true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
