class AddAvatarToRankings < ActiveRecord::Migration[7.0]
  def change
    add_column :rankings, :avatar, :string
  end
end
