class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  def time
    self.created_at.strftime('%d of %B at %H:%M')
  end
end
