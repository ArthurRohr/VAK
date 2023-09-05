class AddDietToMealPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :meal_plans, :diet, :string
  end
end
