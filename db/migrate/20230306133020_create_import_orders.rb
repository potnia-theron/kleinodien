class CreateImportOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :import_orders, id: :uuid do |t|
      t.string :code, null: false
      t.string :kind, null: false
      t.column :state, :smallint, null: false
      t.string :type
      t.string :uri
      t.references :import_order, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
