class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :styles, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum sex: { 男: true, 女: false}
  enum height: {"身長非公開" => 0, "150㎝未満" => 1, "150cm〜155cm" => 2, "155cm〜160cm" => 3, "160cm〜165cm" => 4, "165cm〜170cm" => 5,
                "170cm〜175cm" => 6, "175cm〜180cm" => 7, "180cm〜185cm" => 8, "185cm〜190cm" => 9, "190cm以上" => 10 }
  enum weight: {"体重非公開" =>0, "45kg未満" => 1, "45kg〜50kg" => 2, "50kg〜55kg" => 3, "55kg〜60kg" => 4, "60kg〜65kg" => 5,
                "65kg〜70kg" => 6, "70kg〜75kg" => 7, "75kg〜80kg" => 8, "80kg〜85kg" => 9, "85kg以上" => 10}
  # enum height: { 非公開: 0,150cm未満: 1,150cm〜155cm: 2,155cm〜160cm: 3,160cm〜165cm: 4,165cm〜170cm: 5,170cm〜175cm: 6,175cm〜180cm: 7,180cm〜185cm: 8,185cm〜190cm: 9,190cm以上: 10}
  # enum weight: { 非公開: 0,45kg未満: 1,45kg〜50kg: 2,50kg〜55kg: 3,55kg〜60kg: 4,60kg〜65kg: 5,65kg〜70kg: 6,70kg〜75kg: 7,75kg〜80kg: 8,80kg〜85kg: 9,85kg以上: 10} 半角数字が英語扱いとなり、英語と日本語が入り混じるため使用不可。（英語のみ、日本語のみで構成）

end
