# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string
#  subject    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  has_many :conversation_questions
  has_many :converations, through: :conversation_questions
end
