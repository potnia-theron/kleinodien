class CreateEditions < ActiveRecord::Migration[8.0]
  def change
    create_table :editions, id: :uuid do |t|
      t.references :archetype, null: false, foreign_key: true, type: :uuid
      t.string :editionable_type
      t.uuid :editionable_id

      t.timestamps
    end
  end
end
