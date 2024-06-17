class OrdersController < ApplicationController
  before_action :move_to_session
  before_action :move_to_index
  before_action :set_item

  def index
    @order_address = OrderAddress.new
    # PAY.JP公開鍵情報
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      # バリデーションを通過した場合にPayjpによる決済処理を実施（pay_item）
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def move_to_session
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def move_to_index
    item = Item.find(params[:item_id])
    return unless current_user.id == item.user_id || Order.where(id: params[:item_id]).exists?

    redirect_to root_path
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :address_municipalities, :address_street, :address_building,
                                          :phone_number).merge(token: params[:token], item_id: params[:item_id],
                                                               user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵
    item = Item.find(params[:item_id])
    # 決済処理
    Payjp::Charge.create(
      amount: item.price, # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                # 通貨の種類（日本円）
    )
  end
end
