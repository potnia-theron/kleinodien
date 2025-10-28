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

ActiveRecord::Schema[8.0].define(version: 2025_10_28_201134) do
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

  create_table "centrals", primary_key: "centralable_id", id: :uuid, default: nil, force: :cascade do |t|
    t.string "centralable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "edition_positions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "alphanumeric"
    t.integer "no", limit: 2, null: false
    t.uuid "edition_id", null: false
    t.uuid "edition_section_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["edition_id"], name: "index_edition_positions_on_edition_id"
    t.index ["edition_section_id"], name: "index_edition_positions_on_edition_section_id"
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

  create_table "import_orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "import_order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "import_orderable_type"
    t.uuid "import_orderable_id"
    t.uuid "user_id", null: false
    t.index ["import_order_id"], name: "index_import_orders_on_import_order_id"
    t.index ["user_id"], name: "index_import_orders_on_user_id"
  end

  create_table "link_kinds", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "link_phrase"
    t.string "reverse_link_phrase"
    t.string "long_link_phrase"
    t.uuid "musicbrainz_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "begin_date"
    t.integer "begin_date_accuracy", limit: 2
    t.date "end_date"
    t.integer "end_date_accuracy", limit: 2
    t.uuid "source_id", null: false
    t.uuid "destination_id", null: false
    t.uuid "link_kind_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["destination_id"], name: "index_links_on_destination_id"
    t.index ["link_kind_id"], name: "index_links_on_link_kind_id"
    t.index ["source_id"], name: "index_links_on_source_id"
  end

  create_table "musicbrainz_import_orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "code", null: false
    t.string "kind", null: false
    t.integer "state", limit: 2, default: 0, null: false
    t.string "uri"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
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

  create_table "urls", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "archetypes", "artist_credits"
  add_foreign_key "artist_credit_participants", "artist_credits"
  add_foreign_key "artist_credit_participants", "participants"
  add_foreign_key "edition_positions", "edition_sections"
  add_foreign_key "edition_positions", "editions"
  add_foreign_key "edition_sections", "editions"
  add_foreign_key "editions", "archetypes"
  add_foreign_key "import_orders", "import_orders"
  add_foreign_key "import_orders", "users"
  add_foreign_key "links", "centrals", column: "destination_id", primary_key: "centralable_id"
  add_foreign_key "links", "centrals", column: "source_id", primary_key: "centralable_id"
  add_foreign_key "links", "link_kinds"
  add_foreign_key "participants", "import_orders", on_delete: :nullify
  add_foreign_key "sessions", "users"
end
