class Ranking < ApplicationRecord
  belongs_to :rankable, polymorphic: true
  # acts_as_list
  belongs_to :user
  belongs_to :team
  mount_uploader :avatar, AvatarUploader
end
