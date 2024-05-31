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

ActiveRecord::Schema[7.1].define(version: 2024_05_30_052937) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "medicines", force: :cascade do |t|
    t.string "medicine_name"
    t.string "use_for"
    t.integer "medicine_mg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
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
    t.index ["medicine_id"], name: "index_time_to_eats_on_medicine_id"
  end

  add_foreign_key "start_end_medicines", "medicines"
  add_foreign_key "time_to_eats", "medicines"
end
