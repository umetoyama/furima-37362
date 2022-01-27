class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
  end

  def create
    @order_delivery_address = OrederDeliveryAddress.new(order_paramas)
    if @order_delivery_address.valid?
      @order_delivery_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:oreder_delivery_address).permit(:item_id).merge(user_id: current_user.id, token: params[:token])
  end

end
