class CreatePowerRankings < ActiveRecord::Migration[7.0]
  def change
    create_table :power_rankings do |t|
      t.integer :week, null: false
      t.integer :year, null: false, default: 2000
      t.belongs_to :user, null: false

      t.timestamps null: false
    end

    add_index :power_rankings, [:week, :year, :user_id], unique: true, name: 'power_rankings_index'
  end
end
