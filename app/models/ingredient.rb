class Ingredient < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :recipes, through: :recipe_ingredients
  has_many :user_ingredients, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
