class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  # has_many :comments
  has_one_attached :image

  VALID_PRICE_REGEX = /\A[0-9]+\z/

  # バリデーション
  with_options presence: true do
    validates :item_name, length: { maximum: 40 }
    validates :item_description, length: { maximum: 1000 }
    validates :price, format: { with: VALID_PRICE_REGEX },
                      numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
    validates :image

    # Activehashバリデーション（ジャンルの選択が「---」(id = 1)の時は保存できないようにする／各項目想定したidより大きい時は保存できないようにする。）
    validates :category_id, numericality: { other_than: 1, less_than: 12 }
    validates :condition_id, numericality: { other_than: 1, less_than: 8 }
    validates :shipping_cost_id, numericality: { other_than: 1, less_than: 4 }
    validates :prefecture_id, numericality: { other_than: 1, less_than: 49 }
    validates :shipping_date_id, numericality: { other_than: 1, less_than: 5 }
  end

  # Activehashアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_date
end
