class ChangeMethodOnRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column :recipes, :method, :text
  end
end
