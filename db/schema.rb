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

ActiveRecord::Schema.define(version: 20160515041530) do

  create_table "comment_push_counts", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "sns_id",     limit: 4
    t.integer  "count",      limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "comment_push_counts", ["sns_id", "count"], name: "index_comment_push_counts_on_sns_id_and_count", using: :btree
  add_index "comment_push_counts", ["user_id", "sns_id"], name: "index_comment_push_counts_on_user_id_and_sns_id", using: :btree

  create_table "notices", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.boolean  "is_show",                   default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "notices", ["is_show"], name: "index_notices_on_is_show", using: :btree

  create_table "ppomppu_freeboard_words", force: :cascade do |t|
    t.integer  "sns_content_id", limit: 4
    t.string   "word",           limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "ppomppu_freeboard_words", ["created_at"], name: "index_ppomppu_freeboard_words_on_created_at", using: :btree
  add_index "ppomppu_freeboard_words", ["sns_content_id", "word"], name: "index_ppomppu_freeboard_words_on_sns_content_id_and_word", unique: true, using: :btree

  create_table "push_lists", force: :cascade do |t|
    t.boolean  "is_push",      default: true
    t.boolean  "is_recommend", default: false
    t.boolean  "is_error",     default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "push_lists", ["is_push"], name: "index_push_lists_on_is_push", using: :btree

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
    t.integer  "comment_count",   limit: 4,     default: 0
  end

  add_index "sns_contents", ["description"], name: "index_sns_contents_on_description", length: {"description"=>10}, using: :btree
  add_index "sns_contents", ["recommend_count", "comment_count"], name: "index_sns_contents_on_recommend_count_and_comment_count", using: :btree
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
    t.integer  "push_list_id",   limit: 4
  end

  add_index "user_push_contents", ["is_push"], name: "index_user_push_contents_on_is_push", using: :btree
  add_index "user_push_contents", ["push_list_id"], name: "index_user_push_contents_on_push_list_id", using: :btree
  add_index "user_push_contents", ["user_id", "sns_content_id"], name: "index_user_push_contents_on_user_id_and_sns_content_id", unique: true, using: :btree

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
