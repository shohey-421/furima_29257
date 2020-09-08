class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item_user

  def create
    Favorite.create(item_id:@item.id, user_id: @user.id)
    redirect_to  item_path(@item.id)
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    redirect_to  item_path(@item.id)
  end
 
  private 
  def set_item_user
    @item = Item.find(params[:item_id])
    @user = User.find(current_user.id)
  end

end