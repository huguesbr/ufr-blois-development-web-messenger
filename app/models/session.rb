class Session < ApplicationRecord
  TOKEN_LENGTH = 32

  belongs_to :user

  before_create do |session|
    session.token = SecureRandom.hex(TOKEN_LENGTH)
  end
end
