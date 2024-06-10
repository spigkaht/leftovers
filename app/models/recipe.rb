class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :title, :image_url, :cuisine, :method, :servings, :cook_time, presence: true
  validates :spoonacular_id, presence: true, uniqueness: true
end
