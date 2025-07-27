class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  validates :content, presence: true, length: { maximum: 50 }

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
