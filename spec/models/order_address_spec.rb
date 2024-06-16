require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入機能' do
    context '商品が購入できる場合' do
      it '必要な情報を適切に入力されていれば購入できる' do
        expect(@order_address).to be_valid
      end
      it '都道府県のidが2の場合は購入できる' do
        @order_address.prefecture_id = 2
        expect(@order_address).to be_valid
      end
      it '都道府県のidが48の場合は購入できる' do
        @order_address.prefecture_id = 48
        expect(@order_address).to be_valid
      end
      it '建物名の情報がなくても購入できる' do
        @order_address.address_building = ''
        expect(@order_address).to be_valid
      end
      it '電話番号が10文字で入力されている場合は購入できる' do
        @order_address.phone_number = '0801111222'
        expect(@order_address).to be_valid
      end
      it '電話番号が11文字で入力されている場合は購入できる' do
        @order_address.phone_number = '08011111222'
        expect(@order_address).to be_valid
      end
    end
    context '商品が購入できない場合' do
      it '郵便番号が入力されていない場合は購入できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post code can't be blank")
      end
      it '郵便番号が-（ハイフン）で入力されていない場合は購入できない' do
        @order_address.post_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid')
      end
      it '郵便番号が半角英字で入力されている場合は購入できない' do
        @order_address.post_code = 'aaa-aaaa'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid')
      end
      it '郵便番号が半角カナで入力されている場合は購入できない' do
        @order_address.post_code = 'ｶｶｶ-ｶｶｶｶ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid')
      end
      it '郵便番号が半角記号で入力されている場合は購入できない' do
        @order_address.post_code = '@@@-@@@@'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid')
      end
      it '郵便番号が全角英字で入力されている場合は購入できない' do
        @order_address.post_code = 'ｂｂｂ-ｂｂｂｂ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid')
      end
      it '郵便番号が全角カナで入力されている場合は購入できない' do
        @order_address.post_code = 'カカカ-カカカカ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid')
      end
      it '郵便番号が全角漢字で入力されている場合は購入できない' do
        @order_address.post_code = '嗚呼亜-嗚呼亜阿'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid')
      end
      it '郵便番号が全角記号で入力されている場合は購入できない' do
        @order_address.post_code = '＠＠＠-＠＠＠＠'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Post code is invalid')
      end
      it '発送元の地域（都道府県）の情報が存在しない場合は購入できない' do
        @order_address.prefecture_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank", 'Prefecture is not a number')
      end
      it '都道府県のidが1の場合は購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '都道府県のidが48より大きい場合は購入できない' do
        @order_address.prefecture_id = 49
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Prefecture must be less than 49')
      end
      it '市区町村の情報が存在しない場合は購入できない' do
        @order_address.address_municipalities = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address municipalities can't be blank")
      end
      it '番地の情報が存在しない場合は購入できない' do
        @order_address.address_street = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address street can't be blank")
      end
      it '電話番号の情報が存在しない場合は購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank", 'Phone number is invalid')
      end
      it '電話番号が半角英字で入力されている場合は購入できない' do
        @order_address.phone_number = 'aaaaaaaaaa'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が半角カナで入力されている場合は購入できない' do
        @order_address.phone_number = 'ｱｱｱｱｱｱｱｱｱｱ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が半角記号で入力されている場合は購入できない' do
        @order_address.phone_number = '@@@@@@@@@@'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が全角英字で入力されている場合は購入できない' do
        @order_address.phone_number = 'ｂｂｂｂｂｂｂｂｂｂ'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が全角漢字で入力されている場合は購入できない' do
        @order_address.phone_number = '嗚呼嗚呼嗚呼嗚呼嗚呼'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が全角記号で入力されている場合は購入できない' do
        @order_address.phone_number = '＠＠＠＠＠＠＠＠＠＠'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が全角カナで入力されている場合は購入できない' do
        @order_address.phone_number = 'アアアアアアアアアア'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が9文字で入力されている場合は購入できない' do
        @order_address.phone_number = '080111222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12文字で入力されている場合は購入できない' do
        @order_address.phone_number = '080111111222'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号がハイフンを含む場合は購入できない' do
        @order_address.phone_number = '080-111-122'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークン情報が存在しない場合は購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いていないと保存できない' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できない' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
