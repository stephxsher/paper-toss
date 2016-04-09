class AddStuffToUsers < ActiveRecord::Migration
  def change
    add_column :users, :karma, :integer
    add_column :users, :location_id, :integer
  end
end
