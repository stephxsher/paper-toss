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
