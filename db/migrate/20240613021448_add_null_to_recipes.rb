class AddNullToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_column :recipes, :summary, :text
    change_column_null :recipes, :image_url, true
    change_column_null :recipes, :cuisine, true
    change_column_null :recipes, :method, true
    change_column_null :recipes, :servings, true
    change_column_null :recipes, :cook_time, true
  end
end
