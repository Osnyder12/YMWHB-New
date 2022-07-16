class PowerRanking < ApplicationRecord
  belongs_to :user
  has_many :rankings, as: :rankable
end
