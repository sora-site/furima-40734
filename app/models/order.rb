class Order < ApplicationRecord
  # tokenのgetter/setterを定義
  attr_accessor :token

  # アソシエーション
  belongs_to :user
  belongs_to :item
  has_one :address

  # token（attr_accessorで取得）のバリデーション
  validates :token, presence: true
end
