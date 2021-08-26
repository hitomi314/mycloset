class Item < ApplicationRecord
  belongs_to :category
  belongs_to :style
  belongs_to :user
  has_one :review, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :related_items, dependent: :destroy
  accepts_nested_attributes_for :images
  accepts_attachments_for :images, attachment: :image

  # attachment :image

  enum item_sex: { ユニセックス: 0, メンズ: 1, レディース: 2, キッズ: 3, ボーイズ: 4, ガールズ: 5, ベビー: 6 }
  enum season: { オールシーズン: 0, 春夏: 1, 秋冬: 2 }

  validates :name, presence: true
  # validates :body, presence: true
end
