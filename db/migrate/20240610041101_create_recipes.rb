class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :image_url
      t.string :cuisine
      t.string :method
      t.integer :servings
      t.integer :cook_time
      t.integer :spoonacular_id

      t.timestamps
    end
  end
end
