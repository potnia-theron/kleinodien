class RemoveArtistCreditIdFromAlbumArchetypes < ActiveRecord::Migration[8.0]
  def change
    remove_reference :album_archetypes, :artist_credit, null: false, foreign_key: true, type: :uuid
  end
end
