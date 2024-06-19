require "uri"
require "net/http"

class SearchRecipesByIngredients
  def initialize(user)
    @user = user
  end

  def call
    url = URI("https://api.spoonacular.com/recipes/findByIngredients?ingredients=#{format_ingredients}&fillIngredients=true&number=25&apiKey=#{ENV['SPOONACULAR_API_KEY']}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    if response.code.include?'200'
      results_array = JSON.parse(response.read_body)
      id_array = (results_array.map do |results_hash|
                  results_hash["id"]
                  end)
      id_ingredient_array = (results_array.map do |results_hash|
                             {
                             id: results_hash["id"],
                             missedIngredients: results_hash["missedIngredients"],
                             missedIngredientCount: results_hash["missedIngredientCount"]
                             }
                             end)
      recipe_ids = id_array.join(',')

      url = URI("https://api.spoonacular.com/recipes/informationBulk?ids=#{recipe_ids}&apiKey=#{ENV['SPOONACULAR_API_KEY']}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      response = https.request(request)
      results_array = JSON.parse(response.read_body)
      recipe_array = (results_array.map do |result_hash|
        Recipe.find_by(spoonacular_id: result_hash["id"]) || create_recipe(result_hash)
      end)
      Recipe.where(spoonacular_id: recipe_array.map(&:spoonacular_id))
    else
      return false
    end
  end

  def create_recipe(result_hash)
    method = result_hash["analyzedInstructions"] == [] ? ["No instructions provided!"] : result_hash["analyzedInstructions"][0]["steps"]
    cuisine = result_hash["cuisines"].empty? ? "None" : result_hash["cuisines"].first
    image = result_hash["image"] != nil ? result_hash["image"] : "https://res.cloudinary.com/dp0apr6y4/image/upload/v1718670469/no-image_wliawa.webp"
    recipe = Recipe.create(title: result_hash["title"],
      summary: result_hash["summary"],
      image_url: image,
      cuisine: cuisine,
      method: method,
      servings: result_hash["servings"],
      cook_time: result_hash["readyInMinutes"],
      spoonacular_id: result_hash["id"]
      )
    create_recipe_ingredients(result_hash["extendedIngredients"], recipe)
    recipe
  end

  def create_recipe_ingredients(result_ingredients, new_recipe)
    result_ingredients.map do |ingredient|
      new_ingredient = Ingredient.find_or_create_by(name: ingredient["name"])
      RecipeIngredient.find_or_create_by(recipe: new_recipe, ingredient: new_ingredient)
    end
  end

  def format_ingredients
    @user.ingredients.map {|ingredient| ingredient.name}.join(',')
  end
end
