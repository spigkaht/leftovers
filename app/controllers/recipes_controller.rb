class RecipesController < ApplicationController
  def index
    @user_ingredient = UserIngredient.new
    @recipes = SearchRecipesByIngredients.new(current_user).call
    raise
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
