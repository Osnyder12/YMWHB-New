class AddPublishedToPowerRankings < ActiveRecord::Migration[7.0]
  def up
    add_column :power_rankings, :published, :boolean, default: false
  end

  def down
    remove_column :power_rankings, :published
  end
end
