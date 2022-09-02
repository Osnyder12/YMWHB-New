class PowerRanking < ApplicationRecord
  belongs_to :user
  has_many :rankings, as: :rankable, dependent: :destroy_async
  mount_uploader :avatar, AvatarUploader

  def has_rankings?
    rankings.present?
  end

  def pr_avatar
    avatar.present? ? avatar.url : 'burrow.png'
  end
end
