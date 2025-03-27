class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links, id: :uuid do |t|
      t.date :begin_data
      t.column :begin_date_accuracy, :smallint
      t.date :end_date
      t.column :end_date_accuracy, :smallint
      t.references :source, null: false, foreign_key: {to_table: :centrals, primary_key: :centralable_id}, type: :uuid
      t.references :destination, null: false, foreign_key: {to_table: :centrals, primary_key: :centralable_id}, type: :uuid
      t.references :link_kind, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
