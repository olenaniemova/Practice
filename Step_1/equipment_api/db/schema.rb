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

ActiveRecord::Schema.define(version: 20180610162339) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "item_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_bookings_on_item_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
  end

  create_table "category_filters", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "filter_id"
    t.index ["category_id"], name: "index_category_filters_on_category_id"
    t.index ["filter_id"], name: "index_category_filters_on_filter_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
  end

  create_table "filter_options", force: :cascade do |t|
    t.string "value"
    t.bigint "filter_id"
    t.index ["filter_id"], name: "index_filter_options_on_filter_id"
  end

  create_table "filters", force: :cascade do |t|
    t.string "title"
  end

  create_table "item_options", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "filter_option_id"
    t.index ["filter_option_id"], name: "index_item_options_on_filter_option_id"
    t.index ["item_id"], name: "index_item_options_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.bigint "user_id"
    t.string "reviewable_type"
    t.bigint "reviewable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable_type_and_reviewable_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.index ["city_id"], name: "index_users_on_city_id"
  end

  add_foreign_key "items", "categories"
  add_foreign_key "users", "cities"
end