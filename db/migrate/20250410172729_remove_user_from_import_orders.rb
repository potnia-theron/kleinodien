class RemoveUserFromImportOrders < ActiveRecord::Migration[8.0]
  def change
    reversible do |direction|
      direction.up do
        remove_foreign_key :import_orders, :users
        remove_column :import_orders, :user_id, type: :uuid
      end

      direction.down do
        add_column :import_orders, :user_id, :uuid
        add_foreign_key :import_orders, :users, type: :uuid
      end
    end
  end
end
