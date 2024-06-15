class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @order = Order.create(order_params)
    Address.create(address_params)
    redirect_to root_path
  end

  private

  def order_params
    params.permit.merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def address_params
    params.permit(:post_code, :prefecture_id, :address_municipalities, :address_street, :address_building,
                  :phone_number).merge(order_id: @order.id)
  end
end
