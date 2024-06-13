require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品が出品できる場合' do
      it '必要な情報を適切に入力されていれば登録できる' do
        expect(@item).to be_valid
      end
      it '値段が300円の場合は登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it '値段が9,999,999円の場合は登録できる' do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end
      it 'カテゴリーidが2の場合は登録できる' do
        @item.category_id = 2
        expect(@item).to be_valid
      end
      it 'カテゴリーidが11の場合は登録できる' do
        @item.category_id = 11
        expect(@item).to be_valid
      end
      it 'コンディションidが2の場合は登録できる' do
        @item.condition_id = 2
        expect(@item).to be_valid
      end
      it 'コンディションidが7の場合は登録できる' do
        @item.condition_id = 7
        expect(@item).to be_valid
      end
      it '配送料の負担を示すidが2の場合は登録できる' do
        @item.shipping_cost_id = 2
        expect(@item).to be_valid
      end
      it '配送料の負担を示すidが3の場合は登録できる' do
        @item.shipping_cost_id = 3
        expect(@item).to be_valid
      end
      it '都道府県のidが2の場合は登録できる' do
        @item.prefecture_id = 2
        expect(@item).to be_valid
      end
      it '都道府県の負担のidが48の場合は登録できる' do
        @item.prefecture_id = 48
        expect(@item).to be_valid
      end
      it '発送までの日数を示すidが2の場合は登録できる' do
        @item.shipping_date_id = 2
        expect(@item).to be_valid
      end
      it '発送までの日数を示すidが4の場合は登録できる' do
        @item.shipping_date_id = 4
        expect(@item).to be_valid
      end
    end

    context '商品が出品できない場合' do
      it '商品画像が存在しない場合は登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が存在しない場合は登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it '商品の説明が存在しない場合は登録できない' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item description can't be blank")
      end
      it 'カテゴリーの情報が存在しない場合は登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank", 'Category is not a number')
      end
      it 'カテゴリーidが1の場合は登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be other than 1')
      end
      it 'カテゴリーidが11より大きいの場合は登録できない' do
        @item.category_id = 12
        @item.valid?
        expect(@item.errors.full_messages).to include('Category must be less than 12')
      end
      it '値段の情報が存在しない場合は登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '値段が３００円未満場合は登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
      end
      it '値段が9,999,999円より大きい場合は登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
      end
      it 'priceフィールドは半角英字を許容しない' do
        @item.price = 'aaaaaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceフィールドは半角カナを許容しない' do
        @item.price = 'ｱｱｱｱｱｱｱｱ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceフィールドは半角記号を許容しない' do
        @item.price = '@@@@@@@'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceフィールドは全角英字を許容しない' do
        @item.price = 'ｂｂｂｂｂ'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceフィールドは全角カナを許容しない' do
        @item.price = 'アアアアアア'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it 'priceフィールドは全角漢字を許容しない' do
        @item.price = '阿阿阿阿阿阿'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not a number')
      end
      it '商品の状態の情報が存在しない場合は登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank", 'Condition is not a number')
      end
      it 'コンディションidが1の場合は登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be other than 1')
      end
      it 'コンディションidが7より大きい場合は登録できない' do
        @item.condition_id = 8
        @item.valid?
        expect(@item.errors.full_messages).to include('Condition must be less than 8')
      end
      it '配送料の負担の情報が存在しない場合は登録できない' do
        @item.shipping_cost_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping cost can't be blank", 'Shipping cost is not a number')
      end
      it '配送料の負担を示すidが1の場合は登録できない' do
        @item.shipping_cost_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping cost must be other than 1')
      end
      it '配送料の負担を示すidが3より大きい場合は登録できない' do
        @item.shipping_cost_id = 4
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping cost must be less than 4')
      end
      it '発送元の地域（都道府県）の情報が存在しない場合は登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank", 'Prefecture is not a number')
      end
      it '都道府県のidが1の場合は登録できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '都道府県の負担のidが48より大きい場合は登録できない' do
        @item.prefecture_id = 49
        @item.valid?
        expect(@item.errors.full_messages).to include('Prefecture must be less than 49')
      end
      it '発送までの日数の情報が存在しない場合は登録できない' do
        @item.shipping_date_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date can't be blank", 'Shipping date is not a number')
      end
      it '発送までの日数を示すidが1の場合は登録できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping date must be other than 1')
      end
      it '発送までの日数を示すidが4より大きい場合は登録できない' do
        @item.shipping_date_id = 5
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping date must be less than 5')
      end
    end
  end
end
