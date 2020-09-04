class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: params[:id])

    orders = Order.where(user_id: params[:id])
    @purchased = []
    orders.each do |order|
      item_id = order.item_id
      item = Item.find(item_id)
      @purchased.push(item)
    end
  end
end
