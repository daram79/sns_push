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

ActiveRecord::Schema.define(version: 20160512175807) do

  create_table "recommend_push_counts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "sns_id",     limit: 4
    t.integer  "count",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "recommend_push_counts", ["sns_id", "count"], name: "index_recommend_push_counts_on_sns_id_and_count", using: :btree
  add_index "recommend_push_counts", ["user_id", "sns_id"], name: "index_recommend_push_counts_on_user_id_and_sns_id", using: :btree

  create_table "sns", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sns_contents", force: :cascade do |t|
    t.integer  "sns_id",          limit: 4
    t.integer  "content_id",      limit: 8
    t.string   "title",           limit: 255
    t.string   "url",             limit: 255
    t.text     "description",     limit: 65535
    t.boolean  "is_push"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "recommend_count", limit: 4,     default: 0
  end

  add_index "sns_contents", ["description"], name: "index_sns_contents_on_description", length: {"description"=>10}, using: :btree
  add_index "sns_contents", ["title"], name: "index_sns_contents_on_title", using: :btree

  create_table "sns_push_keys", force: :cascade do |t|
    t.integer  "sns_id",     limit: 4
    t.string   "key",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "sns_push_keys", ["sns_id", "key"], name: "index_sns_push_keys_on_sns_id_and_key", using: :btree

  create_table "user_push_contents", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "sns_content_id", limit: 4
    t.boolean  "is_push",                  default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "user_push_contents", ["is_push"], name: "index_user_push_contents_on_is_push", using: :btree

  create_table "user_push_keys", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "sns_push_key_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "user_push_keys", ["sns_push_key_id"], name: "index_user_push_keys_on_sns_push_key_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.text     "registration_id",      limit: 65535
    t.boolean  "is_push",                            default: true
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "recommend_push_count", limit: 4
  end

  add_index "users", ["recommend_push_count"], name: "index_users_on_recommend_push_count", using: :btree

end
