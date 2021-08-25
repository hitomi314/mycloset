class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user_id, uniqueness: { scope: :review_id }
  # 重複して登録はできない
end
