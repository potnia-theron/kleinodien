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

ActiveRecord::Schema[8.0].define(version: 2025_03_06_083332) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "album_archetypes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "discogs_code"
    t.uuid "musicbrainz_code"
    t.integer "wikidata_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "album_editions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "discogs_code"
    t.uuid "musicbrainz_code"
    t.integer "wikidata_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "archetypes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "archetypeable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "artist_credit_id"
    t.uuid "archetypeable_id"
    t.index ["artist_credit_id"], name: "index_archetypes_on_artist_credit_id"
  end

  create_table "artist_credit_participants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "artist_credit_id", null: false
    t.text "join_phrase"
    t.uuid "participant_id", null: false
    t.integer "position", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_credit_id"], name: "index_artist_credit_participants_on_artist_credit_id"
    t.index ["participant_id"], name: "index_artist_credit_participants_on_participant_id"
  end

  create_table "artist_credits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "edition_sections", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "alphanumeric"
    t.integer "level", limit: 2
    t.integer "no", limit: 2
    t.uuid "edition_id", null: false
    t.integer "positions_count", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["edition_id"], name: "index_edition_sections_on_edition_id"
  end

  create_table "editions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "archetype_id", null: false
    t.string "editionable_type"
    t.uuid "editionable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archetype_id"], name: "index_editions_on_archetype_id"
  end

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
    t.integer "begin_date_accuracy", limit: 2
    t.date "end_date"
    t.integer "end_date_accuracy", limit: 2
    t.uuid "import_order_id"
    t.integer "discogs_code"
    t.text "imdb_code"
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

  create_table "song_archetypes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "discogs_code"
    t.uuid "musicbrainz_code"
    t.integer "wikidata_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "song_editions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "discogs_code"
    t.uuid "musicbrainz_code"
    t.integer "wikidata_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "archetypes", "artist_credits"
  add_foreign_key "artist_credit_participants", "artist_credits"
  add_foreign_key "artist_credit_participants", "participants"
  add_foreign_key "edition_sections", "editions"
  add_foreign_key "editions", "archetypes"
  add_foreign_key "email_verification_tokens", "users"
  add_foreign_key "import_orders", "import_orders"
  add_foreign_key "import_orders", "users"
  add_foreign_key "participants", "import_orders", on_delete: :nullify
  add_foreign_key "password_reset_tokens", "users"
  add_foreign_key "sessions", "users"
end
