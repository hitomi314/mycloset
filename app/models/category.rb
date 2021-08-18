class Category < ApplicationRecord
  has_many :item, dependent: :destroy
end
