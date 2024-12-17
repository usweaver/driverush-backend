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

ActiveRecord::Schema[7.1].define(version: 2024_12_17_092556) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.uuid "user"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_bookings_on_car_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "range_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.bigint "rental_agency_id", null: false
    t.string "model"
    t.string "range"
    t.bigint "brand_id", null: false
    t.string "type"
    t.string "drive"
    t.string "gearbox"
    t.string "fuel_type"
    t.integer "autonomy"
    t.integer "horsepower"
    t.integer "torque"
    t.integer "acceleration"
    t.integer "seating_capacity"
    t.integer "trunk"
    t.integer "frunk"
    t.integer "price_per_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id"], name: "index_cars_on_brand_id"
    t.index ["rental_agency_id"], name: "index_cars_on_rental_agency_id"
  end

  create_table "rental_agencies", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "zipcode"
    t.string "city"
    t.string "opening_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bookings", "cars"
  add_foreign_key "cars", "brands"
  add_foreign_key "cars", "rental_agencies"
end
