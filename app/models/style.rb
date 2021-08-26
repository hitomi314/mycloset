class Style < ApplicationRecord
  has_many :items, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
end
