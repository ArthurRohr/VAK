class CreateNutritionalValues < ActiveRecord::Migration[7.0]
  def change
    create_table :nutritional_values do |t|
      t.float :calories
      t.float :total_fat
      t.float :saturated_fat
      t.float :sodium
      t.float :carbs
      t.float :dietary_fiber
      t.float :sugar
      t.float :protein
      t.float :cholesterol
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
