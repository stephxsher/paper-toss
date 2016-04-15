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

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
