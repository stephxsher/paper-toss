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

class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  layout false

  def create
    if params[:conversation].present?
      if Conversation.between(params[:conversation][:sender_id],params[:conversation][:recipient_id]).present?
        @conversation = Conversation.between(params[:conversation][:sender_id],params[:conversation][:recipient_id]).first
      else
        @conversation = Conversation.create!(sender_id:params[:conversation][:sender_id],recipient_id:params[:conversation][:recipient_id])
      end
      @conversation.update(admin_pair:true)
      # @conversation.save
      flash[:notice] = "Pair successfully submitted"
      redirect_to admin_path(current_user)
    else
      if Conversation.between(params[:sender_id],params[:recipient_id]).present?
        @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
      else
        @conversation = Conversation.create!(conversation_params)
      end
      render json: { conversation_id: @conversation.id }
    end

  end

  def show
    @conversation = Conversation.find(params[:id])
    @reciever = interlocutor(@conversation)
    @messages = @conversation.messages
    @message = Message.new
    unsorted_contents = @conversation.conversation_questions + @conversation.messages
    @contents = unsorted_contents.sort_by(&:created_at).map{|content| content.class == ConversationQuestion ? content.question : content}
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
