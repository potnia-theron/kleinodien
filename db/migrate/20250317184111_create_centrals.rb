class CreateCentrals < ActiveRecord::Migration[8.0]
  def change
    create_table :centrals, id: false, primary_key: :centralable_id do |t|
      t.uuid :centralable_id, primary_key: true
      t.string :centralable_type

      t.timestamps
    end
  end
end
