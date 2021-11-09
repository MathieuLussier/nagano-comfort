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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20211109050913) do

  create_table "bedroom_neighbors", :id => false, :force => true do |t|
    t.integer  "bedroom_id",  :null => false
    t.integer  "neighbor_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "bedroom_statuses", :force => true do |t|
    t.string   "key",        :null => false
    t.string   "label",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bedroom_types", :force => true do |t|
    t.string   "key",        :null => false
    t.string   "label",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bedrooms", :force => true do |t|
    t.string   "name",              :null => false
    t.integer  "nb_of_beds",        :null => false
    t.decimal  "price_per_night",   :null => false
    t.integer  "bedroom_type_id",   :null => false
    t.integer  "bedroom_status_id", :null => false
    t.integer  "view_type_id",      :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "discounts", :force => true do |t|
    t.string   "name",            :null => false
    t.decimal  "discount_amount", :null => false
    t.date     "start_date",      :null => false
    t.date     "end_date"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "extra_option_reservation_rels", :id => false, :force => true do |t|
    t.integer  "extra_option_id", :null => false
    t.integer  "reservation_id",  :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "extra_options", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.boolean  "is_billable", :null => false
    t.decimal  "price"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "reservation_bedroom_rels", :id => false, :force => true do |t|
    t.integer  "bedroom_id",     :null => false
    t.integer  "reservation_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "reservations", :force => true do |t|
    t.text     "description"
    t.datetime "in_date",     :null => false
    t.datetime "out_date"
    t.integer  "nb_guests"
    t.integer  "duration"
    t.integer  "customer_id", :null => false
    t.integer  "discount_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "transactions", :force => true do |t|
    t.decimal  "sub_total"
    t.datetime "transaction_date"
    t.integer  "reservation_id",   :null => false
    t.integer  "customer_id",      :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "view_types", :force => true do |t|
    t.string   "key",        :null => false
    t.string   "label",      :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
