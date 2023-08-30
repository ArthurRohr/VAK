class ChangeTimeToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :recipes, :time, :integer, using: "(time::integer)"
  end
end
