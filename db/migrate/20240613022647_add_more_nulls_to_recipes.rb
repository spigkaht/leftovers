class AddMoreNullsToRecipes < ActiveRecord::Migration[7.1]
  def change
    change_column_null :recipes, :summary, true
  end
end
