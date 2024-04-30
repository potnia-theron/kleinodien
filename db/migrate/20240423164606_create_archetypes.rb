class CreateArchetypes < ActiveRecord::Migration[7.1]
  def change
    create_table :archetypes, id: :uuid do |t|
      t.string :title
      t.string :archetypeable_type
      t.string :archetypeable_id

      t.timestamps
    end
  end
end
