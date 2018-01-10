class AddConfirmedToFriendships < ActiveRecord::Migration[5.1]
  def change
    add_column :friendships, :confirmed, :boolean, :default => false, :null => false
  end
end
