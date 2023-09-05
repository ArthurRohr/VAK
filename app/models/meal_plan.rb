class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :meal_plan_recipes
  has_many :recipes, through: :meal_plan_recipes, dependent: :destroy
  has_one_attached :picture

  DAYS = [1, 2, 3, 4, 5, 6, 7]
end
