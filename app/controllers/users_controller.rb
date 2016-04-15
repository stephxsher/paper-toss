# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string
#  last_name              :string
#  hire_date              :datetime
#  department             :string
#  karma                  :integer
#  location_id            :integer
#  time_zone              :string
#  admin                  :boolean          default(FALSE)
#

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

