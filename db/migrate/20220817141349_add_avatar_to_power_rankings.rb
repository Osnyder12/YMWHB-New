class AddAvatarToPowerRankings < ActiveRecord::Migration[7.0]
  def change
    add_column :power_rankings, :avatar, :string
  end
end
