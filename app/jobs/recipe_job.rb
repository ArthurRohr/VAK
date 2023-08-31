class RecipeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    meal_plan = MealPlan.find(args[0])
    prompt = "" # PRECISA DETERMINAR O PROMPT
    # Do something later
    response = JSON.parse(OpenaiService.new(prompt).call)
    # Parse the response and createa a new meal
    meal = Meal.new # TO DO PRECISA TERMINAR
    meal.meal_plan = meal_plan
    meal.save
  end
end
