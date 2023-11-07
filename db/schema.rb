# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_10_22_083916) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "content", null: false
    t.bigint "song_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["song_id"], name: "index_comments_on_song_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "inqueries", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.text "content", null: false
    t.datetime "created_at"
    t.datetime "closed_at"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "request_instruments", force: :cascade do |t|
    t.bigint "user_request_id", null: false
    t.bigint "instrument_id", null: false
    t.index ["instrument_id"], name: "index_request_instruments_on_instrument_id"
    t.index ["user_request_id", "instrument_id"], name: "index_request_instruments_on_user_request_id_and_instrument_id", unique: true
    t.index ["user_request_id"], name: "index_request_instruments_on_user_request_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "title", null: false
    t.integer "cover", null: false
    t.string "name"
    t.string "artist_name"
    t.bigint "vtuber_id"
    t.string "video_url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title", "name", "artist_name"], name: "index_songs_on_title_and_name_and_artist_name"
    t.index ["vtuber_id"], name: "index_songs_on_vtuber_id"
  end

  create_table "user_favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "song_id", null: false
    t.index ["song_id"], name: "index_user_favorites_on_song_id"
    t.index ["user_id", "song_id"], name: "index_user_favorites_on_user_id_and_song_id", unique: true
    t.index ["user_id"], name: "index_user_favorites_on_user_id"
  end

  create_table "user_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "channnel_status", null: false
    t.string "name", null: false
    t.string "url", null: false
    t.string "member_name"
    t.index ["name"], name: "index_user_requests_on_name"
    t.index ["url"], name: "index_user_requests_on_url", unique: true
    t.index ["user_id"], name: "index_user_requests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password", null: false
    t.string "salt"
    t.text "profile"
    t.integer "role", limit: 2, default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "icon"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  create_table "vtuber_instruments", force: :cascade do |t|
    t.bigint "vtuber_id", null: false
    t.bigint "instrument_id", null: false
    t.index ["instrument_id"], name: "index_vtuber_instruments_on_instrument_id"
    t.index ["vtuber_id", "instrument_id"], name: "index_vtuber_instruments_on_vtuber_id_and_instrument_id", unique: true
    t.index ["vtuber_id"], name: "index_vtuber_instruments_on_vtuber_id"
  end

  create_table "vtubers", force: :cascade do |t|
    t.string "channel_name", null: false
    t.string "channel_url", null: false
    t.string "name"
    t.string "icon"
    t.bigint "instrument_id"
    t.text "overview"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_name", "name"], name: "index_vtubers_on_channel_name_and_name"
    t.index ["instrument_id"], name: "index_vtubers_on_instrument_id"
  end

  add_foreign_key "comments", "songs"
  add_foreign_key "comments", "users"
  add_foreign_key "request_instruments", "instruments"
  add_foreign_key "request_instruments", "user_requests"
  add_foreign_key "songs", "vtubers"
  add_foreign_key "user_favorites", "songs"
  add_foreign_key "user_favorites", "users"
  add_foreign_key "user_requests", "users"
  add_foreign_key "vtuber_instruments", "instruments"
  add_foreign_key "vtuber_instruments", "vtubers"
  add_foreign_key "vtubers", "instruments"
end
