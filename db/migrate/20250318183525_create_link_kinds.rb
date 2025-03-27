class CreateLinkKinds < ActiveRecord::Migration[8.0]
  def change
    create_table :link_kinds, id: :uuid do |t|
      t.string :name
      t.string :description
      t.string :link_phrase
      t.string :reverse_link_phrase
      t.string :long_link_phrase
      t.uuid :musicbrainz_code

      t.timestamps
    end
  end
end
