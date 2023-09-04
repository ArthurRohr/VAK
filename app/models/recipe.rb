class Recipe < ApplicationRecord
  belongs_to :user
  has_many :users, through: :bookmarks
  has_many :meal_plans, through: :meal_plan_recipes
  has_one :nutritional_value

  has_one_attached :picture
  attribute :ai_created, default: false

  CUISINE = ["Italian", "Indian", "Mexican", "Japanese", "Chinese", "French", "Thai", "Mediterranean", "American", "Greek"]
  DIET = ["Vegetarian", "Non-vegetarian", "Vegan", "Gluten-free", "Keto", "Paleo"]

  include PgSearch::Model
  pg_search_scope :search_everywhere,
  against: [ :name, :ingredients, :time, :cuisine, :diet ],
  using: {
    tsearch: { prefix: true }
  }
end
