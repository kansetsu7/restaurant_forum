class AddCategoryToRestaurants < ActiveRecord::Migration[5.1]
  def change
    add_column :restaurants, :category, :string
  end
end
