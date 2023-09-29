class AddTypeToPowerRankings < ActiveRecord::Migration[7.0]
  def change
    add_column :power_rankings, :type, :string, null: false, default: 'PowerRanking::FullRanking'
  end
end
