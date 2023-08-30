class Recipe < ApplicationRecord
  belongs_to :user
  has_many :users, through: :bookmarks
  has_many :meal_plans, through: :meal_plan_recipes

  has_one_attached :pictures
  attribute :ai_created, default: false

  CUISINE = ["Italian", "Indian", "Mexican", "Japanese", "Chinese", "French", "Thai", "Mediterranean", "American", "Greek"]
  DIET = ["Vegetarian", "Non-vegetarian", "Vegan", "Gluten-free", "Keto", "Paleo"]
end
