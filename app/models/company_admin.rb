# == Schema Information
#
# Table name: company_admins
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CompanyAdmin < ActiveRecord::Base
  belongs_to :user
end
