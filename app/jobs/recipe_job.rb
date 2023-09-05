require 'open-uri'
class RecipeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # meal_plan = MealPlan.find(args[0])
    # recipes = args[1]
    # raise
    # prompt = "Generate recipe instructions for the recipe #{recipes["title"]} and add nutritional values. Give the data in a json format with the keys instructions and nutritional value. " #NEED TO FINISH THE PROMPT
    # # Do something later
    # response = JSON.parse(OpenaiService.new(prompt).call)
    # raise
    # # Parse the response and createa a new meal
    # meal = Meal.new
    # meal.meal_plan = meal_plan
    # meal.save

    # meal_plan_recipe = MealPlanRecipe.new(meal_plan: meal_plan, recipe: recipe, day_number: day_number, meal_time: args[1]["meal_time"])
    recipe = args[1]
    meal_plan = MealPlan.find(args[0])
    response = args[2]
    current_user = args[3]
    day = args[4]
    json_format = '{
      "recipe": {
        "instructions": ["step1", "step2", "step3"],
        "cooking_time": "cooking time",
        "servings": "number of servings",
        "cuisine": "the cuisine",
        "nutrition": give me like that {
          "calories": "calories",
          "total_fat": "total fat",
          "saturated_fat": "saturated fat",
          "sodium": "sodium",
          "carbs": "carbs",
          "dietary_fiber": "dietary fiber",
          "sugar": "sugar",
          "protein": "protein",
          "cholesterol": "cholesterol"

        }
      }
      }'.gsub('\n', '')
      prompt = "Give the details of this recipe #{recipe["title"]}, with the ingredients #{recipe["ingredients"]}. please only respond with this json format: #{json_format}."

    # Do something later
    json_response = OpenaiService.new(prompt).call
    recipe_response = JSON.parse(json_response)

    file = URI.open(OpenaiService.new(recipe["title"]).getImageUrl)

    # Parse the response and createa a new meal
    day_number = response.keys

    # ingredients = recipe_response["recipe"]["ingredients"].join(",")
    ingredients = recipe["ingredients"]
    instructions = recipe_response["recipe"]["instructions"].join(" ")
    recipe = Recipe.new(name: recipe["title"],
      ingredients: ingredients, instructions: instructions,
      time: recipe_response["recipe"]["cooking_time"],
      servings: recipe_response["recipe"]["servings"],
      diet: meal_plan.diet, cuisine: recipe_response["recipe"]["cuisine"],
      ai_created: true,

      )
    recipe.picture.attach(io: file, filename: "recipe.png", content_type: "image/png")

    recipe.user = current_user
    recipe.save

    nutrition = recipe_response["recipe"]["nutrition"]

    nutritional = NutritionalValue.new(
      calories: nutrition["calories"]&.gsub('g', '')&.to_f,
      total_fat: nutrition["total_fat"]&.gsub('g', '')&.to_f,
      saturated_fat: nutrition["saturated_fat"]&.gsub('g', '')&.to_f,
      sodium: nutrition["sodium"]&.gsub('mg', '')&.to_f,
      carbs: nutrition["carbs"]&.gsub('g', '')&.to_f,
      dietary_fiber: nutrition["dietary_fiber"]&.gsub('g', '')&.to_f,
      sugar: nutrition["sugar"]&.gsub('g', '')&.to_f,
      protein: nutrition["protein"]&.gsub('g', '')&.to_f,
      cholesterol: nutrition["cholesterol"]&.gsub('mg', '')&.to_f,
      recipe_id: recipe.id
    )
    # Save the nutritional value
    nutritional.save


    meal_plan_recipe = MealPlanRecipe.new(meal_plan_id: meal_plan.id,
      recipe_id: recipe.id, day_number: day_number.first, meal_time: day)
    meal_plan_recipe.save
  end


  def getImage(image_title)
    api_response = OpenaiService.new(image_title).getImageUrl
  end

end
