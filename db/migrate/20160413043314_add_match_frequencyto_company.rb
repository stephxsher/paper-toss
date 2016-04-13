class AddMatchFrequencytoCompany < ActiveRecord::Migration
  def change
    add_column :companies, :match_frequency, :integer, :default => 168
  end
end
