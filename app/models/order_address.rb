class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :address_municipalities, :address_street, :address_building, :phone_number, :user_id,
                :item_id

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

  def save
    # 寄付情報を保存し、変数orderに代入する
    order = Order.create(item_id:, user_id:)
    # 住所を保存する
    Address.create(post_code:, prefecture_id:, address_municipalities:,
                   address_street:, address_building:, phone_number:, order_id: order.id)
  end
end
