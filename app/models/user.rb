class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :teams
  has_many :rankings, as: :rankable
  has_many :power_rankings

  # enum role: {
  #   user: 0,
  #   admin: 1,
  #   super_admin: 2
  # }
end
