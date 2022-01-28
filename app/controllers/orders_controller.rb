class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    @order_delivery_address = OrderDeliveryAddress.new
  end

  def create
    # binding.pry
    @item = Item.find(params[:item_id])
    @order_delivery_address = OrderDeliveryAddress.new(order_params)
    # binding.pry
    if @order_delivery_address.valid?
      pay_item
      @order_delivery_address.storage
      return redirect_to root_path
    else
      render :index
      # render 'index'
    end
  end

  private

  def order_params
    params.require(:order_delivery_address).permit(:postal_code, :prefecture_id, :municipalities, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

end
