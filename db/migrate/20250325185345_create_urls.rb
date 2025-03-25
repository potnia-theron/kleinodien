class CreateUrls < ActiveRecord::Migration[8.0]
  def change
    create_table :urls, id: :uuid do |t|
      t.string :address, null: false

      t.timestamps
    end
  end
end
