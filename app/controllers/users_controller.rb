class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
      #should pass through user you're paired with
      @users = User.where.not("id = ?",current_user.id).order("created_at DESC")
      @conversations = Conversation.involving(current_user).order("created_at DESC")
      @match = (User.all - [current_user]).sample
      @convo = current_user.conversations.build(recipient_id:@match.id)
  end
end

