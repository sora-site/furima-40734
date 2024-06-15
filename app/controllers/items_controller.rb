class ItemsController < ApplicationController
  before_action :move_to_index, only: [:update, :edit]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    redirect_to new_user_session_path unless user_signed_in?
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

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    return unless @item.user_id != current_user.id

    redirect_to root_path
  end

  def update
    redirect_to root_path unless user_signed_in?
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :item_description, :category_id, :price, :condition_id, :shipping_cost_id,
                                 :prefecture_id, :shipping_date_id, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    return if user_signed_in?

    redirect_to action: :index
  end
end
