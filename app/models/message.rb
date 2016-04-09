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

class Message < ActiveRecord::Base

  belongs_to :conversation
  belongs_to :user

  validates_presence_of :content, :conversation_id, :user_id
end
