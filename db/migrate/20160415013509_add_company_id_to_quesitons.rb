class AddCompanyIdToQuesitons < ActiveRecord::Migration
  def change
    add_column :questions, :company_id, :integer
  end
end
