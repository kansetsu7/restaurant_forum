class ChangeCategoryIdDefaultInRestaurants2 < ActiveRecord::Migration[5.1]
  def change
    change_column_default(:restaurants, :category_id, nil)
  end
end
