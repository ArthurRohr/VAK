class DashboardController < ApplicationController
  def dashboard
    @recipes = user_recipes
    @meal_plans = user_meal_plans
    @recipe_count = Recipe.where(user_id: current_user.id).count
    @meal_plan_count = MealPlan.where(user_id: current_user.id).count
    @bookmarks_count = Bookmark.where(user_id: current_user.id).count
    @user_recipes = current_user.recipes.order(created_at: :desc).limit(5)
  end

  private

  def user_recipes
    @recipes = Recipe.where(user_id: current_user)
  end

  def user_meal_plans
    @meal_plans = MealPlan.where(user_id: current_user)
  end
end
