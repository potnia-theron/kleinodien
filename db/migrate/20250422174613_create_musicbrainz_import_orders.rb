class CreateMusicbrainzImportOrders < ActiveRecord::Migration[8.0]
  def change
    remove_column :import_orders, :code, :string
    remove_column :import_orders, :kind, :string
    remove_column :import_orders, :state, :smallint
    remove_column :import_orders, :uri, :string

    add_column :import_orders, :import_orderable_type, :string
    add_column :import_orders, :import_orderable_id, :uuid

    create_table :musicbrainz_import_orders, id: :uuid do |t|
      t.uuid :code, null: false
      t.string :kind, null: false
      t.column :state, :smallint, null: false, default: 0
      t.string :uri

      t.timestamps
    end
  end
end
