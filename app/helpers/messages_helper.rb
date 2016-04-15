# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  content         :string
#  user_id         :integer
#  conversation_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module MessagesHelper
  def self_or_other(message)
    message.user == current_user ? "self" : "other"
  end

  def message_interlocutor(message)
    message.user == message.conversation.sender ? message.conversation.sender : message.conversation.recipient
  end
end

