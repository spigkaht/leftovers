class RecipesController < ApplicationController
  def index
    @user_ingredient = UserIngredient.new
    @recipes = SearchRecipesByIngredients.new(current_user).call
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def favourites
    @favourites = Favourite.where(user: current_user)
  end
end
