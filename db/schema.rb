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

ActiveRecord::Schema[7.1].define(version: 2024_07_29_185432) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "medicines", force: :cascade do |t|
    t.string "medicine_name"
    t.string "use_for"
    t.integer "medicine_mg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.bigint "user_id"
    t.boolean "completed", default: false
    t.index ["user_id"], name: "index_medicines_on_user_id"
  end

  create_table "push_subscribes", force: :cascade do |t|
    t.string "endpoint"
    t.string "string"
    t.string "p256db"
    t.string "auth"
    t.boolean "subscribed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_push_subscribes_on_user_id"
  end

  create_table "start_end_medicines", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.boolean "everyday"
    t.bigint "medicine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["medicine_id"], name: "index_start_end_medicines_on_medicine_id"
  end

  create_table "time_to_eats", force: :cascade do |t|
    t.time "time_to_eat"
    t.bigint "medicine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["medicine_id"], name: "index_time_to_eats_on_medicine_id"
    t.index ["user_id"], name: "index_time_to_eats_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "time_zone"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "medicines", "users"
  add_foreign_key "push_subscribes", "users"
  add_foreign_key "start_end_medicines", "medicines"
  add_foreign_key "time_to_eats", "medicines"
  add_foreign_key "time_to_eats", "users"
end
