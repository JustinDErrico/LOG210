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

ActiveRecord::Schema.define(:version => 20140709044838) do

  create_table "administrators", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "address"
    t.date     "dateOfBirth"
    t.string   "emailAddress"
    t.string   "name"
    t.string   "password"
    t.string   "phoneNumber"
    t.string   "clientType"
    t.string   "zipCode"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "commandes", :force => true do |t|
    t.integer  "client_id"
    t.integer  "restaurant_id"
    t.datetime "deliveryTime"
    t.string   "deliveryAddress"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "entrepreneurs", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "menus", :force => true do |t|
    t.integer  "restaurant_id"
    t.string   "nom"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "plats", :force => true do |t|
    t.integer  "menu_id"
    t.string   "nom"
    t.string   "description"
    t.float    "prix"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "produits", :force => true do |t|
    t.integer  "commande_id"
    t.integer  "plat_id"
    t.integer  "quantity"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "entrepreneur_id"
    t.integer  "restaurator_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "restaurators", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
