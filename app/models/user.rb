class User < ApplicationRecord
  # Devise モジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 投稿との関連
  has_many :posts, dependent: :destroy

  # アバター画像添付
  has_one_attached :avatar

  # ニックネーム必須
  validates :nickname, presence: true

  # いいね機能の関連付け
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # 投稿が既にいいねされているか確認
  def liked?(post)
    likes.exists?(post_id: post.id)
  end
end