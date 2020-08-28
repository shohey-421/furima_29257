class OrdersController < ApplicationController

  def index
    @order = OrderAddress.new
    @item = Item.find (params[:item_id])
  end

  def create
    @order = OrderAddress.new(order_params)
    if @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params_item_id = params.permit(:item_id)
    params.require(:order_address).permit(:postcode, :region_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id,item_id: params_item_id[:item_id])
  end

end
