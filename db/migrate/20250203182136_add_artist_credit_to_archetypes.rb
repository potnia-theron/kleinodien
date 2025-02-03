class AddArtistCreditToArchetypes < ActiveRecord::Migration[8.0]
  def change
    add_reference :archetypes, :artist_credit, foreign_key: true, type: :uuid
  end
end
