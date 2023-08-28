class CreateMealPlans < ActiveRecord::Migration[7.0]
  def change
    create_table :meal_plans do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.text :grocery_list
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
