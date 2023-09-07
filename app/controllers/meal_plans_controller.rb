require 'open-uri'

class MealPlansController < ApplicationController

  def index
    @meal_plans = MealPlan.where(user: current_user)
  end

  def show
    @meal_plan = MealPlan.find(params[:id])
    @meal_plan_recipes = @meal_plan.meal_plan_recipes
  end

  def new
    @meal_plan = MealPlan.new
  end

  def destroy
    @meal_plan = MealPlan.find(params[:id])
    @meal_plan.destroy
    redirect_to meal_plans_path
  end


  def create
    @meal_plan = MealPlan.new(meal_plan_params)
    @meal_plan.user = current_user
    response = ai_meal_plan(@meal_plan)
    onlyfood = "only pictures of food"
    diet = meal_plan_params[:diet] == '' ? "food" : meal_plan_params[:diet, onlyfood]
    file = URI.open(OpenaiService.new(diet).getImageUrl)
    @meal_plan.picture.attach(io: file, filename: "recipe.png", content_type: "image/png")
    if @meal_plan.save
      # recipe-_hash:
      # {"breakfast"=>{"title"=>"Vegan Pancakes", "ingredients"=>"1 cup flour, 1 tablespoon sugar, 2 teaspoons baking powder, 1/2 teaspoon salt, 1 cup almond milk, 1 tablespoon vegetable oil"}, "lunch"=>{"title"=>"Chickpea Salad Sandwich", "ingredients"=>"1 can chickpeas, 1/4 cup vegan mayo, 1/4 cup diced celery, 1/4 cup diced red onion, 1 tablespoon lemon juice, salt and pepper to taste, bread slices"}, "dinner"=>{"title"=>"Vegan Lentil Curry", "ingredients"=>"1 cup lentils, 1 onion (diced), 2 cloves garlic (minced), 1 tablespoon curry powder, 1 can diced tomatoes, 1 can coconut milk, salt and pepper to taste, cooked rice"}}
      response.values.each do |recipe_hash|
        day = 0
        recipe_hash.each do |_, recipe|
          day += 1
          RecipeJob.perform_later(@meal_plan.id, recipe, response, current_user, day)
        end
        # RecipeJob.perform_now(@meal_plan.id, recipe)
      end
      redirect_to meal_plan_path(@meal_plan)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @meal_plan = MealPlan.find(params[:id])
  end

  def ai_meal_plan(meal_plan)
    diet = meal_plan.diet
    days = meal_plan.days
    json_format = {
      "days1": {
            "breakfast":{
              "title":"",
              "ingredients":""
            },
            "lunch":{
              "title":"",
              "ingredients":""
            },
            "dinner":{
              "title":"",
              "ingredients":""
            }
          }
          }.to_s.gsub("\\", "")

    json_response = OpenaiService.new(
      "create a #{diet} meal plan for #{days} days with recipes.
      Only respond with json in the following format: " + json_format
    ).call
    JSON.parse(json_response)

  end

  private

  def meal_plan_params
    params.require(:meal_plan).permit(:name, :days, :diet)
  end

end
