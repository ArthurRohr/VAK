class MealPlansController < ApplicationController

  def index
    @meal_plans = MealPlan.all
  end

  def show
    # @meal_plan = MealPlan.find(params[:id])
    get_new_plan_api
  end

  def new
    @meal_plan = MealPlan.new
  end

  def create
    @meal_plan = MealPlan.new(meal_plan_params)
    @meal_plan.user = current_user
    if @meal_plan.save
      redirect_to meal_plan_path(@meal_plan)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def get_new_plan_api
    response = HTTParty.get('https://api.spoonacular.com/mealplanner/generate', {
      query: {
        apiKey: ENV['MEAL_PLAN_API_KEY'],
        timeFrame: 'week',
        targetCalories: 2000,
        diet: 'vegetarian',
        exclude: 'shellfish,olives'
      }
    })
    @data = JSON.parse(response.body)
    week = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]
    week.each do |day|
      @data["week"][day].each do |meals|
        meals[1].each do |meal|
          if meal.is_a?Hash
            id = meal["id"]
            recipe_response = HTTParty.get("https://api.spoonacular.com/recipes/#{id}/information",{
              query: {
                apiKey: ENV['MEAL_PLAN_API_KEY'],
                includeNutrition: true
              }
            })
            @recipe_data = JSON.parse(recipe_response.body)
          end
        end
      end
    end
  end
end
