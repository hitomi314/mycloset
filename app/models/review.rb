class Review < ApplicationRecord
  belongs_to :item
  has_many :favorite, dependent: :destroy
  has_many :bookmark, dependent: :destroy

  attachment :image
end
