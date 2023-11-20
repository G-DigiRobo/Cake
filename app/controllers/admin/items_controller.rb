class Admin::ItemsController < ApplicationController
  def index
    @item = Item.new
    @items = Item.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "投稿できました"
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "投稿できました"
      redirect_to admin_items_path
    else
      @items = Item.all
      render :new
    end
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:name, :detail, :price, :is_sales_status)
  end
end
