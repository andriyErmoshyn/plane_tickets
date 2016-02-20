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

ActiveRecord::Schema.define(version: 20160218071609) do

  create_table "routes", force: :cascade do |t|
    t.string   "start_point",                                      null: false
    t.string   "end_point",                                        null: false
    t.datetime "depart",                                           null: false
    t.datetime "arrive",                                           null: false
    t.decimal  "price",        precision: 6, scale: 2,             null: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "route_number"
    t.integer  "seats",                                default: 5
  end

  add_index "routes", ["route_number"], name: "index_routes_on_route_number", unique: true

  create_table "tickets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "route_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "status"
  end

  add_index "tickets", ["route_id"], name: "index_tickets_on_route_id"
  add_index "tickets", ["user_id"], name: "index_tickets_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                      null: false
    t.string   "first_name",      limit: 30, null: false
    t.string   "last_name",       limit: 30, null: false
    t.string   "phone_number",               null: false
    t.string   "password_digest"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "remember_digest"
    t.integer  "role"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
