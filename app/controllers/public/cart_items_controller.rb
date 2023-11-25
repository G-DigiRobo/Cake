class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @items = Item.all
    @cart_items= current_customer.cart_items.all
    @sum = @cart_items.inject(0) { |sum, cart_item| sum + cart_item.item.tax_included_price * cart_item.amount }
  end

  def create
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item
      @cart_item.amount += CartItem.new(cart_item_params).amount
    else
      @cart_item = CartItem.new(cart_item_params)
    end
    @cart_item.customer_id = current_customer.id
    if @cart_item.save
      redirect_to cart_items_path
    else
      @genres = Genre.all
      @item = Item.find(params[:cart_item][:item_id])
      render template: "public/items/show"
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_back(fallback_location: root_path)

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

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
