class MealPlan < ApplicationRecord
  belongs_to :user
  has_many :recipes, through: :meal_plan_recipe
end
