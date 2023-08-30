class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    queries = []
    sql_params = []

    if params[:time].present?
      sql_subquery = "time <= :time"
      @recipes = @recipes.where(sql_subquery, time: params[:time])
    end

    if params[:name].present?
      @recipes = @recipes.where("LOWER(name) = ?", params[:name].downcase)
    end

    if params[:ingredients].present?
      params[:ingredients].split(",").each do |ing|
        queries.push("LOWER(ingredients) LIKE ?")
        sql_params.push("%#{ing.downcase}%")
      end
      @recipes = @recipes.where(queries.join(' AND '), *sql_params)
    end

    if params[:cuisine].present?
      @recipes = @recipes.where("LOWER(cuisine) = ?", params[:cuisine].downcase)
    end

    if params[:diet].present?
      @recipes = @recipes.where("LOWER(diet) = ?", params[:diet].downcase)
    end
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
