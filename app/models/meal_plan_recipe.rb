class MealPlanRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :mealPlan
end
