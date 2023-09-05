class RemoveDatesFromMealPlan < ActiveRecord::Migration[7.0]
  def change
    remove_column :meal_plans, :start_date, :date
    remove_column :meal_plans, :end_date, :date
  end
end
