class Admin::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
  end

  def new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end
end
