class PowerRanking < ApplicationRecord
  belongs_to :user
  has_many :rankings, as: :rankable, dependent: :destroy_async
  mount_uploader :avatar, AvatarUploader
end
