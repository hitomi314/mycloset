class Review < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  attachment :image
end
