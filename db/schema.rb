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

ActiveRecord::Schema.define(version: 20161019004229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string   "password_digest"
    t.string   "email",              limit: 64
    t.string   "first_name",         limit: 64
    t.string   "last_name",          limit: 64
    t.string   "phone",              limit: 64
    t.binary   "encrypted_password"
    t.string   "street_address",     limit: 64
    t.string   "city",               limit: 64
    t.string   "state",              limit: 64
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "w9_forms", force: :cascade do |t|
    t.integer  "user_id"
    t.binary   "salt"
    t.binary   "encrypted_ssn"
    t.binary   "encrypted_tax_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["user_id"], name: "index_w9_forms_on_user_id", using: :btree
  end

  add_foreign_key "w9_forms", "users"
end
