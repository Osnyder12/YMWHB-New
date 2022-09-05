class AddTitleToPowerRankings < ActiveRecord::Migration[7.0]
  def up
    add_column :power_rankings, :title, :string
  end

  def down
    remove_column :power_rankings, :title
  end
end
