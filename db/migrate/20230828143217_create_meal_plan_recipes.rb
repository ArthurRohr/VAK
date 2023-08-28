class CreateMealPlanRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :meal_plan_recipes do |t|
      t.integer :day_number
      t.string :meal_time
      t.references :recipe, null: false, foreign_key: true
      t.references :meal_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
