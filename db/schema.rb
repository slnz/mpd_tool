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

ActiveRecord::Schema.define(version: 20151014041145) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campus", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "deposits", force: :cascade do |t|
    t.decimal  "amount"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "postcode"
    t.integer  "status",         default: 0
    t.integer  "giving_method",  default: 0
    t.integer  "designation_id"
    t.integer  "project_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "designations", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "designation_code"
    t.string   "activation_code"
    t.boolean  "email_sent",       default: false
    t.integer  "donee_id"
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
    t.date     "display_date"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.integer  "payment_type",   default: 0
    t.integer  "gift_type",      default: 0
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "pledges", force: :cascade do |t|
    t.integer  "designation_id"
    t.decimal  "amount"
    t.integer  "giving_method"
    t.integer  "donor_id"
    t.boolean  "anonymous",      default: false
    t.boolean  "newsletter",     default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "status",         default: 0
    t.integer  "project_id"
    t.integer  "donation_id"
    t.integer  "contact_id"
    t.text     "payload"
    t.text     "params"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "goal"
    t.text     "description"
    t.date     "date"
    t.string   "slug"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "donor_id"
    t.integer  "designation_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image"
    t.integer  "designation_id"
    t.string   "activation_code"
    t.boolean  "admin",                  default: false
    t.string   "slug"
    t.text     "description"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "phone"
    t.string   "organization"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "postcode"
    t.integer  "donor_state"
    t.boolean  "terms",                  default: false
    t.integer  "donee_state",            default: 0
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
