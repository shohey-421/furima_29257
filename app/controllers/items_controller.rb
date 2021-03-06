class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = Comment.where(item_id: params[:id]).includes(:user)
    @favorites = Favorite.where(item_id: params[:id]).includes(:user)
    @favorite = Favorite.find_by(item_id: params[:id], user_id: current_user.id) if user_signed_in?
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.valid?
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    @results = @q.result(distinct: true)
  end

  private

  def item_params
    params.require(:item).permit({ images: [] }, :name, :description, :category_id, :condition_id, :shipping_burden_id, :ship_from_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless user_signed_in? && @item.user_id == current_user.id
  end
end
