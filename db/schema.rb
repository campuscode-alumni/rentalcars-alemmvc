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

ActiveRecord::Schema.define(version: 2019_11_23_205306) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addon_items", force: :cascade do |t|
    t.integer "addon_id"
    t.string "registration_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.float "daily_rate"
    t.index ["addon_id"], name: "index_addon_items_on_addon_id"
  end

  create_table "addons", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "daily_rate"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "addressable_type"
    t.integer "addressable_id"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
  end

  create_table "car_models", force: :cascade do |t|
    t.string "name"
    t.string "year"
    t.integer "manufacture_id"
    t.text "car_options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "motorization"
    t.integer "fuel_type_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_car_models_on_category_id"
    t.index ["fuel_type_id"], name: "index_car_models_on_fuel_type_id"
    t.index ["manufacture_id"], name: "index_car_models_on_manufacture_id"
  end

  create_table "cars", force: :cascade do |t|
    t.integer "car_model_id"
    t.integer "car_km"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "license_plate"
    t.string "color"
    t.integer "status", default: 0
    t.index ["car_model_id"], name: "index_cars_on_car_model_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "daily_rate"
    t.float "third_party_insurance"
    t.float "car_insurance"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cpf"
    t.string "cnpj"
    t.string "trade_name"
  end

  create_table "fuel_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufactures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rental_items", force: :cascade do |t|
    t.integer "rental_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rentable_type"
    t.integer "rentable_id"
    t.float "daily_rate"
    t.index ["rentable_type", "rentable_id"], name: "index_rental_items_on_rentable_type_and_rentable_id"
    t.index ["rental_id"], name: "index_rental_items_on_rental_id"
  end

  create_table "rental_prices", force: :cascade do |t|
    t.float "daily_rate"
    t.integer "subsidiary_id"
    t.integer "category_id"
    t.float "daily_car_insurance"
    t.float "daily_third_party_insurance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_rental_prices_on_category_id"
    t.index ["subsidiary_id"], name: "index_rental_prices_on_subsidiary_id"
  end

  create_table "rentals", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.integer "client_id"
    t.integer "category_id"
    t.integer "subsidiary_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price_projection"
    t.string "reservation_code"
    t.index ["category_id"], name: "index_rentals_on_category_id"
    t.index ["client_id"], name: "index_rentals_on_client_id"
    t.index ["subsidiary_id"], name: "index_rentals_on_subsidiary_id"
  end

  create_table "subsidiaries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cnpj"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.integer "subsidiary_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["subsidiary_id"], name: "index_users_on_subsidiary_id"
  end

end
