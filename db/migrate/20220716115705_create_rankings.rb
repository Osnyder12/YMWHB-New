class CreateRankings < ActiveRecord::Migration[7.0]
  def change
    create_table :rankings do |t|
      t.integer :rank_number
      t.string :description
      t.references :rankable, polymorphic: true, null: false
      t.belongs_to :user, nuull: false
      t.integer :team_id
      t.integer :position

      t.timestamps
    end
    add_index :rankings, [:team_id, :rankable_id, :rankable_type], unique: true, name: 'rankings_index'
  end
end
