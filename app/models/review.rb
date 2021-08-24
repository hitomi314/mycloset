class Review < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
  # すでにブックマークが存在しているか検証

end
