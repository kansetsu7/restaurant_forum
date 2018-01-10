class AddStatusToFriendships < ActiveRecord::Migration[5.1]
  def change
    add_column :friendships, :status, :string, :default => 'unconfirmed', :null => false
    remove_column :friendships, :confirmed
  end
end
