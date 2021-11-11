class Membership < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  def belongs_to?(a_user)
    a_user == user
  end
end
