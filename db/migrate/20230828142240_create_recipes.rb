class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :ingredients
      t.text :instructions
      t.string :time
      t.string :cuisine
      t.string :diet
      t.boolean :ai_created
      t.string :servings
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
