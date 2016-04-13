class AddAdminPairtoConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :admin_pair, :boolean, :default => false
  end
end
