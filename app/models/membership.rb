class Membership < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  def belongs_to?(a_user)
    a_user == user
  end

  def editable_by?(a_user)
    chat.user == a_user
  end
end
