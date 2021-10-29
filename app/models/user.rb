class User < ApplicationRecord
  has_many :chats, dependent: :destroy
  has_many :messages, dependent: :destroy
end
