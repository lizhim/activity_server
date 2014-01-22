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

ActiveRecord::Schema.define(version: 20140121034808) do

  create_table "activities", force: true do |t|
    t.string   "user_name"
    t.string   "activity_name"
    t.string   "enrollment"
    t.string   "bidder"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adimns", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "password_confirm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bid_lists", force: true do |t|
    t.string   "user_name"
    t.string   "activity_name"
    t.string   "bid_name"
    t.string   "name"
    t.string   "price"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bid_status"
  end

  create_table "bids", force: true do |t|
    t.string   "user_name"
    t.string   "activity_name"
    t.string   "bid_name"
    t.string   "bid_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sign_up"
    t.string   "bid_status"
  end

  create_table "price_counts", force: true do |t|
    t.string   "user_name"
    t.string   "activity_name"
    t.string   "bid_name"
    t.string   "price"
    t.string   "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sign_ups", force: true do |t|
    t.string   "user_name"
    t.string   "activity_name"
    t.string   "name"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_confirm"
    t.string   "question"
    t.string   "answer"
    t.string   "admin"
  end

  create_table "winners", force: true do |t|
    t.string   "user_name"
    t.string   "activity_name"
    t.string   "bid_name"
    t.string   "name"
    t.string   "phone"
    t.string   "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
