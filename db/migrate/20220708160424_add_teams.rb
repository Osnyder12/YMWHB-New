class AddTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.string :team_name, null: false
      t.string :team_owner, null: false
      t.belongs_to :user, null: false
      t.string :image

      t.timestamps null: false
    end
  end
end
