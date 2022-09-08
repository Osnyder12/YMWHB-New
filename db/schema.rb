# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_08_130711) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "power_rankings", force: :cascade do |t|
    t.integer "week", null: false
    t.integer "year", default: 2000, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "title"
    t.string "introduction_paragraph"
    t.index ["user_id"], name: "index_power_rankings_on_user_id"
    t.index ["week", "year", "user_id"], name: "power_rankings_index", unique: true
  end

  create_table "rankings", force: :cascade do |t|
    t.integer "rank_number"
    t.string "description"
    t.string "rankable_type", null: false
    t.bigint "rankable_id", null: false
    t.bigint "user_id"
    t.integer "team_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["rankable_type", "rankable_id"], name: "index_rankings_on_rankable"
    t.index ["team_id", "rankable_id", "rankable_type"], name: "rankings_index", unique: true
    t.index ["user_id"], name: "index_rankings_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_name"
    t.string "team_owner"
    t.string "image"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user", null: false
    t.boolean "pr_editor", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "teams", "users"
end
