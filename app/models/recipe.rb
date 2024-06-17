class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  validates :title, :image_url, :cuisine, :servings, :cook_time, presence: true
  validates :spoonacular_id, presence: true, uniqueness: true

  # CUSTOM METHOD TO FILTER YO
  scope :by_cuisine, ->(cuisine) { where(cuisine: cuisine) }
  scope :by_ingredient, ->(ingredients) { joins(:ingredients).where(ingredients: { id: ingredients }) }
end
