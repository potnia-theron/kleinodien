class FixLinksData < ActiveRecord::Migration[8.0]
  def change
    rename_column(:links, :begin_data, :begin_date)
  end
end
