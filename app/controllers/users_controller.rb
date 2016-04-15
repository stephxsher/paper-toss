class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
      #should pass through user you're paired with
      @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
      @conversations = Conversation.involving(current_user).order("created_at DESC")

      if current_user.currently_available?
        @match = current_user.best_match
      else
        last_convo = Conversation.involving(current_user).last
        @match = last_convo.conversation_partner(current_user)
      end
      @convo = current_user.conversations.build(recipient_id:@match.id)
  end

  def show
    @user = current_user
    @conversations = Conversation.involving(current_user).order("created_at DESC")
    @users = @user.recent_conversations(@conversations)
    @users.take(3)

  end


  def conversations
      @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
      @conversations = Conversation.involving(current_user).order("created_at DESC")
  end
end

