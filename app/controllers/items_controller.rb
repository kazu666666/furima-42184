class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :move_to_index, only: [:edit, :update]

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

  def update
    @item = Item.find(params[:id])
     if @item.update(item_params)
      redirect_to item_path(@item)
     else
      render :edit, status: :unprocessable_entity
     end 
  end

  def edit
    @item = Item.find(params[:id])
  end

  #def destroy
  #end

  private

  def item_params
    params.require(:item).permit(:image,:name,:description,:category_id,:status_id,:shipping_id,:prefecture_id,:shipping_day_id,:price).merge(user_id: current_user.id)
  end

  def move_to_index
    @item = Item.find(params[:id])
    unless current_user == @item.user
      redirect_to root_path
    end
  end
  
end
