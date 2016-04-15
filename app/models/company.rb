# == Schema Information
#
# Table name: companies
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  match_frequency :integer          default(168)
#

class Company < ActiveRecord::Base
  has_many :locations
  has_many :users, through: :locations
  accepts_nested_attributes_for :locations

  def employee_count
    self.users.count
  end

end
