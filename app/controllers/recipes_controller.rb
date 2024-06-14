class RecipesController < ApplicationController
  RECIPE_ARRAY_ID = :recipe_ids_array

  # POST /recipes/update_search_results
  def update_search_results
    @recipes = SearchRecipesByIngredients.new(current_user).call
    save_recipe_ids_to_session(@recipes)
    redirect_to recipes_path
  end

  def index
    @user_ingredient = UserIngredient.new
    @recipes = retrieve_recipes_from_session
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def favourites
    @favourites = Favourite.where(user: current_user)
  end

  private

  def save_recipe_ids_to_session(recipes)
    json_str = recipes.map { |recipe| recipe.id }.to_a.to_json
    session[RECIPE_ARRAY_ID] = json_str
  end

  def retrieve_recipes_from_session
    json_array = session[RECIPE_ARRAY_ID] || '[]'
    Recipe.where(id: JSON.parse(json_array))
  end
end
