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

ActiveRecord::Schema.define(version: 20151016120121) do

  create_table "bookings", force: true do |t|
    t.integer  "user_id"
    t.integer  "listing_id"
    t.date     "start"
    t.date     "end"
    t.boolean  "owner_approved"
    t.datetime "owner_approved_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "tenant_approved"
    t.datetime "tenant_approved_at"
    t.integer  "tenant_id"
    t.integer  "point_cost"
    t.boolean  "owner_declined"
    t.datetime "owner_declined_at"
    t.boolean  "tenant_declined"
    t.datetime "tenant_declined_at"
    t.boolean  "tenant_reviewed"
    t.datetime "tenant_reviewed_at"
    t.boolean  "owner_reviewed"
    t.datetime "owner_reviewed_at"
  end

  create_table "listings", force: true do |t|
    t.integer  "property_id"
    t.date     "start"
    t.date     "end"
    t.integer  "daily_points"
    t.boolean  "active"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "featured"
    t.integer  "user_id"
    t.integer  "minimum_rating"
  end

  create_table "point_logs", force: true do |t|
    t.integer  "booking_id"
    t.integer  "user_id"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", force: true do |t|
    t.text     "title"
    t.text     "address_1"
    t.text     "address_2"
    t.text     "suburb"
    t.text     "state"
    t.text     "post_code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "property_features", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "property_images", force: true do |t|
    t.text     "file_name"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "property_id"
  end

  create_table "property_reviews", force: true do |t|
    t.integer  "property_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "booking_id"
    t.integer  "rating"
  end

  create_table "tenants", force: true do |t|
    t.integer  "user_id"
    t.date     "start"
    t.date     "end"
    t.integer  "maximum_daily_points"
    t.text     "suburb"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  create_table "user_reviews", force: true do |t|
    t.integer  "rating"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "author_id"
    t.integer  "user_id"
    t.integer  "booking_id"
  end

  create_table "users", force: true do |t|
    t.text     "email_address"
    t.text     "password"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "address_1"
    t.text     "address_2"
    t.text     "suburb"
    t.text     "state"
    t.text     "post_code"
    t.text     "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
