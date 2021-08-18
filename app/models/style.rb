class Style < ApplicationRecord
  has_many :item, dependent: :destroy
end
