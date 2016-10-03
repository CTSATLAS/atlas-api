class User < ApplicationRecord
  validates :email, uniqueness: true
  validates :username, length: { maximum: 50 }, uniqueness: true
end
