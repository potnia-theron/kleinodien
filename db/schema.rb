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

ActiveRecord::Schema[7.1].define(version: 2023_10_24_180558) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "email_verification_tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.index ["user_id"], name: "index_email_verification_tokens_on_user_id"
  end

  create_table "import_orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code", null: false
    t.string "kind", null: false
    t.integer "state", limit: 2, default: 0, null: false
    t.string "type"
    t.string "uri"
    t.uuid "import_order_id"
    t.uuid "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["import_order_id"], name: "index_import_orders_on_import_order_id"
    t.index ["user_id"], name: "index_import_orders_on_user_id"
  end

  create_table "participants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "sort_name", null: false
    t.text "disambiguation"
    t.date "begin_date"
    t.integer "begin_date_mask", limit: 2
    t.date "end_date"
    t.integer "end_date_mask", limit: 2
    t.uuid "import_order_id"
    t.integer "discogs_code"
    t.integer "imdb_code"
    t.uuid "musicbrainz_code"
    t.integer "tmdb_code"
    t.integer "wikidata_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "password_reset_tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.index ["user_id"], name: "index_password_reset_tokens_on_user_id"
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "email_verification_tokens", "users"
  add_foreign_key "import_orders", "import_orders"
  add_foreign_key "import_orders", "users"
  add_foreign_key "participants", "import_orders", on_delete: :nullify
  add_foreign_key "password_reset_tokens", "users"
  add_foreign_key "sessions", "users"
end
