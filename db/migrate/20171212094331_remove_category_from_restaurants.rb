class RemoveCategoryFromRestaurants < ActiveRecord::Migration[5.1]
  def change
    remove_column :restaurants, :category_id
    drop_table :categories
  end
end
