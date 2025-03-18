class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]
  before_action :redirect_if_sold_out, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @item = Item.new
  end

  def show
  end

  def update
     if @item.update(item_params)
      redirect_to item_path(@item)
     else
      render :edit, status: :unprocessable_entity
     end 
  end

  def edit
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end
  
  def purchase
    @order_address = OrderAddress.new
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image,:name,:description,:category_id,:status_id,:shipping_id,:prefecture_id,:shipping_day_id,:price).merge(user_id: current_user.id)
  end

  def move_to_index
    unless current_user == @item.user
      redirect_to root_path
    end
  end

  def redirect_if_purchased
    redirect_to root_path if @item.order.present?
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: @item.id )
  end

  def redirect_if_sold_out
    if @item.sold_out?
      redirect_to root_path
    end
  end
  
end
