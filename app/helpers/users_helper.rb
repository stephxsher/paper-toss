module UsersHelper
  def user_message(user)
    if user.location == "remote"
      "who works remotely on our #{user.department} team."
    else
      "who works from our #{user.location.name} office in #{user.department}."
    end
  end

  def conversation_interlocutor(conversation)
    conversation.recipient == current_user ? conversation.sender : conversation.recipient
  end
end
