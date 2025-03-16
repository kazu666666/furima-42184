class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]


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
    @item = Item.find(params[:id])
  end

  #def update
  #end

  def edit
    @item = Item.find(params[:id])
  end

  #def destroy
  #end

  private

  def item_params
    params.require(:item).permit(:image,:name,:description,:category_id,:status_id,:shipping_id,:prefecture_id,:shipping_day_id,:price).merge(user_id: current_user.id)
  end

  
end
