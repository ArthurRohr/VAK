class AddDaysToMealPlan < ActiveRecord::Migration[7.0]
  def change
    add_column :meal_plans, :days, :integer
  end
end
