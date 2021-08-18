class Item < ApplicationRecord
  belongs_to :category
  belongs_to :style
  belongs_to :user
  belongs_to :review
  has_many :image, dependent: :destroy
  has_many :related_item, dependent: :destroy

  attachment :image
end
