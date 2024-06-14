require "uri"
require "net/http"

class SearchRecipesByIngredients
  def initialize(user)
    @user = user
  end

  def call
    url = URI("https://api.spoonacular.com/recipes/findByIngredients?ingredients=#{format_ingredients}&apiKey=#{ENV['SPOONACULAR_API_KEY']}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)
    if response.code.include?'200'
      results_array = JSON.parse(response.read_body)
      id_array = (results_array.map do |results_hash|
                  results_hash["id"]
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
      return recipe_array
    else
      return false
    end
  end

  def create_recipe(result_hash)
    method = "No instructions provided!" if result_hash["instructions"].nil?
    cuisine = result_hash["cuisines"].empty? ? "None" : result_hash["cuisines"].first
    recipe = Recipe.create(title: result_hash["title"],
                  summary: result_hash["summary"],
                  image_url: result_hash["image"],
                  cuisine: cuisine,
                  method: (result_hash["instructions"] || method),
                  servings: result_hash["servings"],
                  cook_time: result_hash["readyInMinutes"],
                  spoonacular_id: result_hash["id"]
                  )
    create_recipe_ingredients(result_hash["extendedIngredients"], recipe)
  end

  def create_recipe_ingredients(result_ingredients, new_recipe)
    # raise
    # result_ingredients.map { |ingredient| }
  end

  def format_ingredients
    @user.ingredients.map {|ingredient| ingredient.name}.join(',')
  end
end
