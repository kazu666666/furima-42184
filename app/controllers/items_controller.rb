class ItemsController < ApplicationController
  def index
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
  end

  def edit
  end

  def destroy
  end

  private

  def item_params
    params.require(:item).permit(:name,:description,:category_id,:status_id,:shipping_id,:prefecture_id,:shipping_day_id,:price)
  end

end
