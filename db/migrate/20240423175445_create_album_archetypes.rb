class CreateAlbumArchetypes < ActiveRecord::Migration[7.1]
  def change
    create_table :album_archetypes, id: :uuid do |t|
      t.integer :discogs_code
      t.uuid :musicbrainz_code
      t.integer :wikidata_code

      t.timestamps
    end
  end
end
