class Image < ApplicationRecord
  belongs_to :item

  attachment :image
end
