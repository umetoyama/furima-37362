class ItemsController < ApplicationController
  before_action :move_to_sign_up, except: [:index, :show]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:product_name, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_time_id, :price, :image).merge(user_id: current_user.id)
  end

  def move_to_sign_up
    unless user_signed_in?
      redirect_to "/users/sign_in"
    end
  end

end
