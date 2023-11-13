class CreateArtistCreditParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :artist_credit_participants, id: :uuid do |t|
      t.references :artist_credit, null: false, foreign_key: true, type: :uuid
      t.text :join_phrase
      t.references :participant, null: false, foreign_key: true, type: :uuid
      t.column :position, :smallint, null: false

      t.timestamps
    end
  end
end
