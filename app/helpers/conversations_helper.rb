# == Schema Information
#
# Table name: conversations
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  admin_pair   :boolean          default(FALSE)
#

module ConversationsHelper

end
