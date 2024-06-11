# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Clearing out your junk.."
Favourite.destroy_all
Ingredient.destroy_all
RecipeIngredient.destroy_all
UserIngredient.destroy_all
Recipe.destroy_all
User.destroy_all
puts "Clean!"

emails = [
  "ben@leftovers.com",
  "sam@leftovers.com",
  "prez@leftovers.com"
]

first_names = [
  "Ben",
  "Sam",
  "Prescot"
]

last_names = [
  "Jackson",
  "Singh",
  "Palmer"
]

password = "leftovers"

3.times do |i|
  User.create!(first_name: first_names[i], last_name: last_names[i], email: emails[i], password: password)
  puts "##{i + 1} done"
end
puts "-> users created"

ingredients = ["apple", "banana", "orange", "lemon", "lime"]

5.times do |i|
  Ingredient.create!(name: ingredients[i])
  puts "##{i + 1} done"
end
puts "-> ingredients created"

recipes = [
  {
    title: "Red Lentil Soup with Chicken and Turnips",
    image_url: "https://img.spoonacular.com/recipes/715415-312x231.jpg",
    cuisine: "Italian",
    method: "Insert method here",
    servings: 4,
    cook_time: 90,
    spoonacular_id: 1
  },
  {
    title: "Asparagus and Pea Soup: Real Convenience Food",
    image_url: "https://img.spoonacular.com/recipes/716406-312x231.jpg",
    cuisine: "French",
    method: "Insert method here",
    servings: 8,
    cook_time: 45,
    spoonacular_id: 2
  },
  {
    title: "Garlicky Kale",
    image_url: "https://img.spoonacular.com/recipes/644387-312x231.jpg",
    cuisine: "French",
    method: "Insert method here",
    servings: 6,
    cook_time: 25,
    spoonacular_id: 3
  },
  {
    title: "Crunchy Brussels Sprouts Side Dish",
    image_url: "https://img.spoonacular.com/recipes/640941-312x231.jpg",
    cuisine: "British",
    method: "Insert method here",
    servings: 4,
    cook_time: 15,
    spoonacular_id: 4
  },
]

4.times do |i|
  Recipe.create!(title: recipes[i][:title],
    image_url: recipes[i][:image_url],
    cuisine: recipes[i][:cuisine],
    method: recipes[i][:method],
    servings: recipes[i][:servings],
    cook_time: recipes[i][:cook_time],
    spoonacular_id: recipes[i][:spoonacular_id]
    )
    puts "##{i + 1} done"
end
puts "-> recipes created"

puts "Finished!"
