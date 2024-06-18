class ChangeMethodOnRecipesAgain < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :method, :text
    add_column :recipes, :method, :jsonb, default: []
  end
end
