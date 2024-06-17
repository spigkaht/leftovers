class ChangeMethodOnRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :method, :string
    add_column :recipes, :method, :jsonb, default: []
  end
end
