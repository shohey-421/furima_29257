class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_index
  before_action :check_sold_out

  def index
    @order = OrderAddress.new
  end

  def create
    @order = OrderAddress.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      @item = Item.findorder_params[:item_id]
      render :index
    end
  end

  private

  def order_params
    params_item_id = params.permit(:item_id)
    params.require(:order_address).permit(:postcode, :region_id, :city, :block, :building, :phone_number, :token).merge(user_id: current_user.id, item_id: params_item_id[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: Item.find(order_params[:item_id]).price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.findparams[:item_id]
  end

  def move_to_index
    redirect_to root_path if user_signed_in? && @item.user_id == current_user.id
  end

  def check_sold_out
    redirect_to root_path unless @item.order.nil?
  end
end
