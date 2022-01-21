class ItemsController < ApplicationController

  def index
  end

  def new
    @item = Item.new
  end

  def create
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_time_id, :price).merge(user_id: current_user.id)
  end

end
