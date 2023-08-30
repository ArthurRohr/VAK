# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'open-uri'

Recipe.destroy_all

puts "Generating recipes..."

# Array of possible cuisines and diets
cuisines = ["Italian", "Indian", "Mexican", "Japanese", "Chinese", "French", "Thai", "Mediterranean", "American", "Greek"]
diets = ["Vegetarian", "Non-vegetarian", "Vegan", "Gluten-free", "Keto", "Paleo"]

# Create 20 Faker-generated recipes
20.times do
  Recipe.create(
    name: Faker::Food.dish,
    ingredients: (1..rand(3..10)).map { Faker::Food.ingredient }.join(", "),
    instructions: Faker::Food.description,
    time: "#{rand(10..120)} minutes",
    cuisine: cuisines.sample, # Select a random cuisine from the array
    diet: diets.sample,       # Select a random diet from the array
    ai_created: Faker::Boolean.boolean,
    servings: "#{rand(1..8)}",
    user_id: 1,
  # Assuming you have 10 users
    picture: "https://source.unsplash.com/featured/?food&#{rand(1..2000)}"
  )
end

puts "20 recipes added"
