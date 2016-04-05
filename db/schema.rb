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

ActiveRecord::Schema.define(version: 20160331185344) do

  create_table "album_views", force: :cascade do |t|
    t.integer "album_id"
    t.integer "user_id"
  end

  create_table "albums", force: :cascade do |t|
    t.string  "album_name"
    t.integer "user_id"
    t.string  "url"
  end

  create_table "friends", force: :cascade do |t|
    t.integer "friender_id"
    t.integer "friendee_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "popular_model_id"
    t.string   "popular_model_type"
    t.integer  "friend_id"
    t.string   "friend_type"
    t.boolean  "did_accept"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id", "friend_type"], name: "index_friendships_on_friend_id_and_friend_type"
  add_index "friendships", ["popular_model_id", "popular_model_type"], name: "index_friendships_on_popular_model_id_and_popular_model_type"

  create_table "photos", force: :cascade do |t|
    t.string   "url"
    t.float    "x_coord"
    t.float    "y_coord"
    t.integer  "album_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.date    "birthday"
    t.boolean "f_book"
    t.string  "default_loc"
    t.string  "email"
    t.string  "encrypted_password", limit: 128
    t.string  "confirmation_token", limit: 128
    t.string  "remember_token",     limit: 128
    t.string  "user_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
