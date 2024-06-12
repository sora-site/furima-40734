class Item < ApplicationRecord
  belongs_to :user
  # has_one :purchase
  has_many :comments
  has_one_attached :image

  VALID_PRICE_REGEX = /\A[0-9]+\z/

  # 必須バリデーション
  validates :item_name, presence: true
  validates :item_description, presence: true
  validates :category_id, presence: true
  validates :price, presence: true, format: { with: VALID_PRICE_REGEX },
                    numericality: { only_integer: true, greater_than: 300, less_than: 9_999_999 }
  validates :condition_id, presence: true
  validates :shipping_cost_id, presence: true
  validates :prefecture_id, presence: true
  validates :shipping_date_id, presence: true
  validates :image, presence: true
  # ジャンルの選択が「---」の時は保存できないようにする（activehash）
  validates :category_id, numericality: { other_than: 1 }
  validates :condition_id, numericality: { other_than: 1 }
  validates :shipping_cost_id, numericality: { other_than: 1 }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :shipping_date_id, numericality: { other_than: 1 }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
