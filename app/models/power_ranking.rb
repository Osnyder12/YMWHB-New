class PowerRanking < ApplicationRecord
  self.inheritance_column = 'type_of_power_ranking'

  belongs_to :user
  has_many :rankings, as: :rankable, dependent: :destroy_async
  mount_uploader :avatar, AvatarUploader

  TYPES = ['Full List', 'Three By Three']

  TYPES_HASH = { 'Full List': 'PowerRanking::FullRanking', 'Three By Three': 'PowerRanking::ThreeByThree' }

  def has_rankings?
    rankings.present?
  end

  def pr_avatar
    avatar.url.present? ? avatar.url : 'burrow.png'
  end
end
