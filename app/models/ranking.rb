class Ranking < ApplicationRecord
  belongs_to :rankable, polymorphic: true
  acts_as_list scope: [:rankable_id]
  belongs_to :user
  belongs_to :team
  mount_uploader :avatar, AvatarUploader
end
