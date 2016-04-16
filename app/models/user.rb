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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :location
  has_one :company, through: :location

  has_many :conversations, :foreign_key => :sender_id


  def name_w_initial
    "#{first_name} #{last_name.first}"
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def coworkers
    User.joins(:company).where('companies.id = ?', self.company.id)
  end

  def possible_partners
    coworkers.select do |coworker| 
      coworker.currently_available? && Conversation.between(coworker.id,self.id).count.zero?
    end
  end

  def currently_available?
    if Conversation.involving(self).where(admin_pair:false).present?
      start_of_last_convo = Conversation.involving(self).order("created_at DESC").last.created_at
      ((start_of_last_convo - Time.now).hours > company.match_frequency) ? true : false
    else
      return true
    end
  end

  def best_match
    #if admin paired, return as first match
    if Conversation.involving(self).where(admin_pair:true).present?
      convo = Conversation.involving(self).where(admin_pair:true).first
      return convo.conversation_partner(self)
    end

    #return user that is best match
    possible_partners.max_by do |partner|
      self.score(partner)
    end 
  end 

  def score(match)
    total = 0

    self.department != match.department ? total += 3 : total += 1
    self.location != match.location ? total += 4 : 0
    self.location == "Remote" || match.location == "Remote" ? total += 5 : 0
    
    total
  end

  def recent_conversations(conversations)
    users = []
    conversations.each do |conversation|
      sender = User.find(conversation.sender_id)
      receiver = User.find(conversation.recipient_id)
      if sender != self
       users << sender
      elsif receiver != self
        users << receiver
      end
    end
    users
  end

end
