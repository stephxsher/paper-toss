class CreateCompanyAdmins < ActiveRecord::Migration
  def change
    create_table :company_admins do |t|
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
