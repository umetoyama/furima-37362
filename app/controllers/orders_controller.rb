class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root_path
  before_action :item_select

  def index
    @order_delivery_address = OrderDeliveryAddress.new
  end

  def create
    @order_delivery_address = OrderDeliveryAddress.new(order_params)
    if @order_delivery_address.valid?
      pay_item
      @order_delivery_address.storage
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.require(:order_delivery_address).permit(:postal_code, :prefecture_id, :municipalities, :address, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root_path
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || Order.exists?(item_id: @item.id)
  end

  def item_select
    @item = Item.find(params[:item_id])
  end
end
