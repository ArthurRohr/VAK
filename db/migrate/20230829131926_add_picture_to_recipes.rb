class AddPictureToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :picture, :text
  end
end
