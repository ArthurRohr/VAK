require 'json'

class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
    @recipes = Recipe.search_everywhere(params[:query]) if params[:query].present?
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @ai = params[:ai]
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

    @response = JSON.parse(OpenaiService.new('Recipe with chicken,noodles,brokkoli and its nutrition in the following json format
                                                          {
                                                            "recipe": {
                                                              "title": "",
                                                              "ingredients": [],
                                                              "instructions": [],
                                                              "cooking_time": "",
                                                              "servings": "",
                                                              "nutrition": [:calorie,:total-fat,:saturated-fate,:sodium,:carbs,:fiber,:sugar,:protien,:cholestrol]
                                                            }
                                                          }').call)

    @title = @response["recipe"]["title"]
    @ingredients = @response["recipe"]["ingredients"]
    @instructions = @response["recipe"]["instructions"]
    @cooking_time = @response["recipe"]["cooking_time"]
    @servings = @response["recipe"]["servings"]
    @nutrition = @response["recipe"]["nutrition"]

  end

  def ai_recipe_new
    @recipe = Recipe.new
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredients, :instructions, :time, :cuisine, :diet, :servings, :pictures)
  end
end
