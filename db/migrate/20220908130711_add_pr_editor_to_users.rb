class AddPrEditorToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :pr_editor, :boolean, default: false
  end

  def down
    remove_column :users, :pr_editor
  end
end
