class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_purchased
  before_action :redirect_if_seller

  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid? 
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token], 
      currency: 'jpy'
    )
  end

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :block, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def redirect_if_purchased
    redirect_to root_path if @item.order.present?
  end

  def redirect_if_seller
    redirect_to root_path if @item.user_id == current_user.id
  end

end
