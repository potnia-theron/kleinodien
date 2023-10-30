class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :participants, id: :uuid do |t|
      t.text :name, null: false
      t.text :sort_name, null: false
      t.text :disambiguation
      t.date :begin_date
      t.column :begin_date_accuracy, :smallint
      t.date :end_date
      t.column :end_date_accuracy, :smallint
      # t.references :import_order, null: true, foreign_key: true, type: :uuid
      t.uuid :import_order_id
      t.integer :discogs_code
      t.integer :imdb_code
      t.uuid :musicbrainz_code
      t.integer :tmdb_code
      t.integer :wikidata_code

      t.timestamps
    end

    # There seems to be no way to set "on_delete: :nullify" within
    # the "create_table" block.
    add_foreign_key :participants, :import_orders, on_delete: :nullify
  end
end
