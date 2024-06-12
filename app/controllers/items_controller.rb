class ItemsController < ApplicationController
  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_description, :category_id, :price, :condition_id, :shipping_cost_id, :prefecture_id,
                                 :shipping_date_id, :image).merge(user_id: current_user.id)
  end
end
