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

ActiveRecord::Schema.define(version: 20210526115014) do

  create_table "articles", force: :cascade do |t|
    t.integer "news_id"
    t.string "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reservation_id"
    t.string "name"
    t.string "tel"
    t.string "build_name"
    t.index ["reservation_id"], name: "index_attendances_on_reservation_id"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.datetime "str_time"
    t.datetime "fin_time"
    t.integer "expected"
    t.integer "reserved"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "day"
    t.integer "close"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "department"
    t.datetime "basic_time", default: "2021-05-07 00:00:00"
    t.datetime "work_time", default: "2021-05-07 08:00:00"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
