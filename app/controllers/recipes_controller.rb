class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    @recipes = Recipe.search_everywhere(params[:query]) if params[:query].present?
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def ai_recipe
    @response = OpenaiService.new('Recipe with chicken, lemon').call
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :instructions, :time, :cuisine, :diet, :servings, :pictures)
  end
end
