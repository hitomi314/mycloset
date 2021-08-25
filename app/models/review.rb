class Review < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
  # すでにブックマークが存在しているか検証

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :rate, presence: true
  validates :text, presence: true, length: { maximum: 500}


end
