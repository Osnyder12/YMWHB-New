class Team < ApplicationRecord
  has_many :rankings, as: :rankable
  belongs_to :user
  # has_one_attached :avatar
end
