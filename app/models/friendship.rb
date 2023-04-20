class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  scope :accepted, -> { where(accepted: true) }
end
