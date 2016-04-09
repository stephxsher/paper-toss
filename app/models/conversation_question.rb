# == Schema Information
#
# Table name: conversation_questions
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  question_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ConversationQuestion < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :question
end
