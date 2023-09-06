class DashboardController < ApplicationController
  def dashboard
    @recipes = user_recipes
    @recipes_created = Recipe.where(user_id: current_user.id, ai_created: false)
    @meal_plans = user_meal_plans
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @recipe_count = Recipe.where(user_id: current_user.id, ai_created: false).count
    @recipe_ai_count = Recipe.where(user_id: current_user.id, ai_created: true).count
    @meal_plan_count = MealPlan.where(user_id: current_user.id).count
    @bookmarks_count = Bookmark.where(user_id: current_user.id).count
    @user_recipes = current_user.recipes
  end

  private

  def user_recipes
    @recipes = Recipe.where(user_id: current_user)
  end

  def user_meal_plans
    @meal_plans = MealPlan.where(user_id: current_user)
  end
end
