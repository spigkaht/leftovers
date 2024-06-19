class RecipesController < ApplicationController
  RECIPE_ARRAY_ID = :recipe_ids_array

  # POST /recipes/update_search_results
  def update_search_results
    @recipes = SearchRecipesByIngredients.new(current_user).call
    save_recipe_ids_to_session(@recipes)
    redirect_to recipes_path
  end

  def index
    @id_ingredient_array = []
    @user_ingredient = UserIngredient.new
    @recipes = retrieve_recipes_from_session
    @recipe_cuisines = @recipes.pluck(:cuisine).uniq

    if params[:cuisine].present?
      @recipes = @recipes.by_cuisine(params[:cuisine])
    end

    if params[:ingredients].present?
      ingredients = params[:ingredients].is_a?(Array) ? params[:ingredients] : [params[:ingredients]]
      @recipes = @recipes.by_ingredient(ingredients)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_ingredients_array = []
    @recipe.ingredients.each { |ingredient| @recipe_ingredients_array.push(ingredient) }
    @user_ingredients_array = []
    current_user.ingredients.each { |ingredient| @user_ingredients_array.push(ingredient) }
    client = OpenAI::Client.new
    chaptgpt_response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "user", content: "Please return ONLY a string of ingredient names,
      separated by commas, showing me what I'm missing from this recipe's list of ingredients:
      #{@recipe_ingredients_array}. Here are the ingredients I currently have:
      #{@user_ingredients_array}. If the name of the ingredient in the @recipe_ingredients_array
      contains the name of the ingredient in the @user_ingredients_array, you can leave this out
      of the string that you return."}]
    })
    @content_full = chaptgpt_response["choices"][0]["message"]
    @content = chaptgpt_response["choices"][0]["message"]["content"].split(",")
  end

  def favourites
    @favourites = Favourite.where(user: current_user)
  end

  private

  def save_recipe_ids_to_session(recipes)
    json_str = recipes.map(&:id).to_a.to_json
    session[RECIPE_ARRAY_ID] = json_str
  end

  def retrieve_recipes_from_session
    json_array = session[RECIPE_ARRAY_ID] || '[]'
    Recipe.where(id: JSON.parse(json_array))
  end
end
