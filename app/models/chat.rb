class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  def has_accepted_member?(user)
    Membership.exists?(chat: self, user: user, status: 'accepted')
  end

  # ensure chat's creator have a accepted membership
  # https://apidock.com/rails/ActiveRecord/Callbacks/after_create
  after_create do |chat|
    Membership.create(user: chat.user, chat: chat, status: 'accepted')
  end
end
