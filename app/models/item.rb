class Item < ApplicationRecord
  belongs_to :user
  # has_one :purchase
  has_many :comments
  has_one_attached :image

  VALID_PRICE_REGEX = /\A[0-9]+\z/

  # バリデーション
  validates :item_name, presence: true, length: { maximum: 40 }
  validates :item_description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, format: { with: VALID_PRICE_REGEX },
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :image, presence: true

  # Activehashバリデーション（ジャンルの選択が「---」(id = 1)の時は保存できないようにする／各項目想定したidより大きい時は保存できないようにする。）
  validates :category_id, presence: true, numericality: { other_than: 1, less_than: 12 }
  validates :condition_id, presence: true, numericality: { other_than: 1, less_than: 8 }
  validates :shipping_cost_id, presence: true, numericality: { other_than: 1, less_than: 4 }
  validates :prefecture_id, presence: true, numericality: { other_than: 1, less_than: 49 }
  validates :shipping_date_id, presence: true, numericality: { other_than: 1, less_than: 5 }

  # Activehashアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shiping_cost
  belongs_to :prefecture
  belongs_to :shiping_date
end
