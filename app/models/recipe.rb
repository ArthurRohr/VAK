class Recipe < ApplicationRecord
  belongs_to :user
  has_many :users, through: :bookmarks
  has_many :meal_plans, through: :meal_plan_recipes

  has_one_attached :pictures
  attribute :ai_created, default: false
end
