class ChangeArchetypeIdFromStringToUuid < ActiveRecord::Migration[8.0]
  def up
    remove_column :archetypes, :archetypeable_id
    add_column :archetypes, :archetypeable_id, :uuid
  end

  def down
    remove_column :archetypes, :archetypeable_id
    add_column :archetypes, :archetypeable_id, :string
  end
end
