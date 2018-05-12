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

ActiveRecord::Schema.define(version: 20180507223248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string   "company_name"
    t.string   "website"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "contract_revisions", force: :cascade do |t|
    t.integer  "contract_id"
    t.date     "contract_date"
    t.integer  "rating_1",        default: 0
    t.integer  "rating_2",        default: 0
    t.integer  "rating_3",        default: 0
    t.integer  "rating_4",        default: 0
    t.integer  "rating_5",        default: 0
    t.integer  "rating_6",        default: 0
    t.integer  "rating_7",        default: 0
    t.integer  "rating_8",        default: 0
    t.integer  "rating_9",        default: 0
    t.integer  "rating_10",       default: 0
    t.float    "rating_11",       default: 0.0
    t.float    "rating_12",       default: 0.0
    t.float    "rating_13",       default: 0.0
    t.float    "rating_14",       default: 0.0
    t.float    "total_rating",    default: 0.0
    t.text     "rating_1_note"
    t.text     "rating_2_note"
    t.text     "rating_3_note"
    t.text     "rating_4_note"
    t.text     "rating_5_note"
    t.text     "rating_6_note"
    t.text     "rating_7_note"
    t.text     "rating_8_note"
    t.text     "rating_9_note"
    t.text     "rating_10_note"
    t.text     "additional_note"
    t.string   "number_lawsuit",  default: "0"
    t.integer  "lawsuit_score",   default: 10
    t.text     "ways_to_improve"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "lawsuit_note"
    t.string   "tos_url"
    t.text     "total_page_note"
    t.integer  "total_page"
  end

  create_table "contract_user_ratings", force: :cascade do |t|
    t.integer  "contract_revision_id"
    t.integer  "user_id"
    t.integer  "rating",               default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "comment"
  end

  create_table "contracts", force: :cascade do |t|
    t.string   "contract_title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "contract_type"
    t.integer  "company_id"
    t.string   "website"
    t.string   "application"
    t.index ["company_id"], name: "index_contracts_on_company_id", using: :btree
  end

  create_table "user_loggings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "contract_revision_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "role",                   default: "member", null: false
    t.string   "first_name",             default: "",       null: false
    t.string   "last_name",              default: "",       null: false
    t.string   "country",                default: "",       null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
