class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  def belongs_to?(a_user)
    a_user == user
  end
end
