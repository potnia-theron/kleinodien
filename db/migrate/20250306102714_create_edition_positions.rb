class CreateEditionPositions < ActiveRecord::Migration[8.0]
  def change
    create_table :edition_positions, id: :uuid do |t|
      t.string :alphanumeric
      t.column :no, :smallint, null: false
      t.references :edition, null: false, foreign_key: true, type: :uuid
      t.references :edition_section, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
