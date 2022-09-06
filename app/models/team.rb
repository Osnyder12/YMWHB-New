class Team < ApplicationRecord
  has_many :rankings, as: :rankable
  belongs_to :user
  mount_uploader :avatar, AvatarUploader

  def team_avatar
    avatar.present? ? avatar.url : 'burrow.png'
  end
end
