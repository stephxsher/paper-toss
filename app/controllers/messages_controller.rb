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

class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!

    @path = conversation_path(@conversation)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
