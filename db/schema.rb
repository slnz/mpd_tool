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

ActiveRecord::Schema.define(version: 20151003004037) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campus", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name",             limit: 255
    t.string   "address",          limit: 255
    t.string   "phone",            limit: 255
    t.string   "email",            limit: 255
    t.integer  "code"
    t.integer  "designation_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",               default: 0, null: false
    t.integer  "attempts",               default: 0, null: false
    t.text     "handler",                            null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "designations", force: :cascade do |t|
    t.string   "first_name",       limit: 255
    t.string   "last_name",        limit: 255
    t.string   "email",            limit: 255
    t.integer  "designation_code"
    t.string   "activation_code",  limit: 255
    t.boolean  "email_sent",                   default: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campus_id"
    t.integer  "project_id"
  end

  add_index "designations", ["activation_code"], name: "index_designations_on_activation_code", unique: true, using: :btree

  create_table "donations", force: :cascade do |t|
    t.integer  "global_id"
    t.integer  "contact_id"
    t.integer  "designation_id"
    t.string   "payment_method", limit: 255
    t.date     "display_date"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "goal"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",              limit: 255, default: "",    null: false
    t.string   "encrypted_password", limit: 255, default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",           limit: 255
    t.string   "uid",                limit: 255
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "image",              limit: 255
    t.integer  "designation_id"
    t.string   "activation_code",    limit: 255
    t.boolean  "admin",                          default: false
    t.string   "permalink"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["permalink"], name: "index_users_on_permalink", using: :btree

end
