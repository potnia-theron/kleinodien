class RemoveTypeFromImportOrders < ActiveRecord::Migration[8.0]
  def change
    remove_column :import_orders, :type, :string
  end
end
