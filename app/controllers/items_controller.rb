class ItemsController < ApplicationController
  before_action :authenticate_user! ,only: [:new, :create]

  def index
    
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      return redirect_to root_path
    else
      render "new"
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_burden_id, :ship_from_id, :shipping_date_id, :price)
  end
end
