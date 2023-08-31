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
      # If the params have the :nutritional_values key, you will do the following
      # Instantiate a new nutritional_value model with the values from the params
      # Associate the new instance with the saved @recipe instance
      # save the new instance of nutritional_value
      if params[:nutrition]
        @nutrition = params[:nutrition].split.each_slice(2).to_a.to_h
        @nutrition = NutritionalValue.new(@nutrition)
        @nutrition.recipe = @recipe

        @nutrition.save
      end

      redirect_to recipe_path(@recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def ai_recipe

    @ingredients = params["recipes"]["ingredients"]
    @time = params["recipes"]["time"]
    @cuisine = params["recipes"]["cuisine"]
    @diet = params["recipes"]["diet"]
    @servings = params["recipes"]["servings"]

    prompt = "#{@diet} one Recipe with only #{@ingredients} of type #{@cuisine} in less than #{@time}"

    json_format = "{
      'recipe': {
        'title': '',
        'ingredients': '',
        'instructions': '',
        'cooking_time': '',
        'servings': '',
        'cuisine': '',
        'nutrition': [:calorie,:total-fat,:saturated-fate,:sodium,:carbs,:fiber,:sugar,:protien,:cholestrol]
        }
      }"

    @response = JSON.parse(OpenaiService.new("#{prompt} and its nutrition in the following json format #{json_format}").call)

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
