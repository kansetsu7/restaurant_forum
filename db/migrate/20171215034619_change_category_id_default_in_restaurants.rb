class ChangeCategoryIdDefaultInRestaurants < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:restaurants, :category_id, 1)
  end
end
