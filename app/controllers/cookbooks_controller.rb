class CookbooksController < ApplicationController
  def index
    @user_recipes = Recipe.where(user_id: current_user.id, ai_created: false)
  end
end
