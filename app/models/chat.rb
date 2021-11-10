class Chat < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  # ensure chat's creator have a membership
  # https://apidock.com/rails/ActiveRecord/Callbacks/after_create
  after_create do |chat|
    Membership.create(user: chat.user, chat: chat)
  end
end
