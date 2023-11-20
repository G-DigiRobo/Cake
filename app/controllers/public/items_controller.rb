class Public::ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
  end
end
