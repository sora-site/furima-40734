class Address < ApplicationRecord
  belongs_to :order
  # バリデーション
  VALID_POSTNUM_REGEX = /\A[0-9]{3}-[0-9]{4}\z/
  VALID_PHONENUM_REGEX = /\A[0-9]{10,11}\z/
  with_options presence: true do
    validates :post_code, format: { with: VALID_POSTNUM_REGEX, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, less_than: 49 }
    validates :address_municipalities
    validates :address_street
    validates :phone_number, format: { with: VALID_PHONENUM_REGEX }
  end
end
