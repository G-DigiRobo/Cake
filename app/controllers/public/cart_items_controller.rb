class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @items = Item.all
    @total = 0
  end

  def create
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item
      @cart_item.amount += CartItem.new(cart_item_params).amount
    else
      @cart_item = CartItem.new(cart_item_params)
    end
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
 end


  def delete
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = CartItem.all
    @cart_items.destroy_all
    redirect_to cart_items_path, notice: 'カートが空になりました'
  end
end
