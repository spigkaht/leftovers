class AddColumnsToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :included_ingredients, :integer
    add_column :recipes, :excluded_ingredients, :integer
  end
end
