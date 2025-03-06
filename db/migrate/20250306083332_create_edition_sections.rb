class CreateEditionSections < ActiveRecord::Migration[8.0]
  def change
    create_table :edition_sections, id: :uuid do |t|
      t.string :alphanumeric
      t.column :level, :smallint
      t.column :no, :smallint
      t.references :edition, null: false, foreign_key: true, type: :uuid
      t.column :positions_count, :smallint

      t.timestamps
    end
  end
end
