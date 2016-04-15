class UpdateDefaultsToUsers < ActiveRecord::Migration
  def change
    change_column :users, :location_id,  :integer, :default => 1
  end
end
