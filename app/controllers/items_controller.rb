class ItemsController < ApplicationController

  def index
  end

  def new
  end

  private

  def item_params
    keys_to_allow == :product_name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_time_id, :price
    params.require(:item).permit(keys_to_allow).merge(user_id: current_user.id)
  end

end
