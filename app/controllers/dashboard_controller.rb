class DashboardController < ApplicationController
  def dashboard
    @recipes = user_recipes
    @meal_plans = user_meal_plans
  end

  private

  def user_recipes
    @recipes = Recipe.where(user_id: current_user)
  end

  def user_meal_plans
    @meal_plans = MealPlan.where(user_id: current_user)
  end
end
