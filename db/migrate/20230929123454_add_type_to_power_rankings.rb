class AddTypeToPowerRankings < ActiveRecord::Migration[7.0]
  def change
    add_column :power_rankings, :type, :string
  end
end
