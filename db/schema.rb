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

ActiveRecord::Schema.define(version: 20160627083410) do

  create_table "activities", force: :cascade do |t|
    t.integer  "action_id"
    t.integer  "activity_type"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "activities", ["user_id", "created_at"], name: "index_activities_on_user_id_and_created_at", unique: true
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.date     "publish_date"
    t.string   "author"
    t.integer  "pages"
    t.integer  "category_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "picture"
  end

  add_index "books", ["category_id"], name: "index_books_on_category_id"
  add_index "books", ["title", "publish_date", "author", "category_id"], name: "index_books", unique: true

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["name"], name: "index_category_on_name", unique: true

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["created_at"], name: "index_comments_on_created_at"
  add_index "comments", ["review_id"], name: "index_comments_on_review_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "follows", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follows", ["followed_id"], name: "index_follows_on_followed_id"
  add_index "follows", ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true
  add_index "follows", ["follower_id"], name: "index_follows_on_follower_id"

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "likes", ["activity_id"], name: "index_likes_on_activity_id"
  add_index "likes", ["user_id", "created_at"], name: "index_likes_on_user_id_and_created_at", unique: true
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "marks", force: :cascade do |t|
    t.integer  "read",        default: 0
    t.boolean  "is_favorite", default: false
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "marks", ["book_id"], name: "index_marks_on_book_id"
  add_index "marks", ["read", "is_favorite"], name: "index_mark"
  add_index "marks", ["user_id", "book_id"], name: "index_mark_unique", unique: true
  add_index "marks", ["user_id"], name: "index_marks_on_user_id"

  create_table "requests", force: :cascade do |t|
    t.string   "book_title"
    t.date     "book_publish_date"
    t.string   "book_author"
    t.integer  "user_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "requests", ["user_id", "created_at"], name: "index_requests_on_user_id_and_created_at", unique: true
  add_index "requests", ["user_id"], name: "index_requests_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.text     "content"
    t.integer  "rated"
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["book_id"], name: "index_reviews_on_book_id"
  add_index "reviews", ["rated", "created_at"], name: "index_reviews_on_rated_and_created_at"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "fullname"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "is_admin",        default: false
    t.string   "remember_digest"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "avatar"
  end

  add_index "users", ["fullname", "email"], name: "index_users_on_fullname_and_email", unique: true

end
