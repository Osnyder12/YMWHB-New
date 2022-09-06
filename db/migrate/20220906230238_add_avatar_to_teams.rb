class AddAvatarToTeams < ActiveRecord::Migration[7.0]
  def up
    add_column :teams, :avatar, :string
  end

  def down
    remove_column :teams, :avatar, :string
  end
end
