class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @items = Item.where(user_id: params[:id])

    @purchased = []
    orders = Order.where(user_id: params[:id])
    orders.each do |order|
      item_id = order.item_id
      item = Item.find(item_id)
      @purchased.push(item)
    end

    @favorites = []
    favs = Favorite.where(user_id: params[:id])
    favs.each do |favs|
      item_id = favs.item_id
      item = Item.find(item_id)
      @favorites.push(item)
    end
  end
end
