class AddIntroductionParagraphToPowerRankings < ActiveRecord::Migration[7.0]
  def up
    add_column :power_rankings, :introduction_paragraph, :string
  end
   
  def down
    remove_column :power_rankings, :introduction_paragraph
  end
end
