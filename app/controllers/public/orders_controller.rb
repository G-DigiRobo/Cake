class Public::OrdersController < ApplicationController
  before_action :cartitem_nill,   only: [:new, :create]
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "own_address"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:select_address] == "registered_address"
      @address = Address.find(params[:order][:address_id])
      @order.postcode = @address.postcode
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "new_address"
      @order.customer_id = current_customer.id
    end
    @cart_items = current_customer.cart_items
    @confirm_order = Order.new
    render :confirm
  end

  def create
    order_params[:order_status] = order_params[:order_status].to_i
    order = Order.new(order_params)
    order.save
    @cart_items = current_customer.cart_items.all

    @cart_items.each do |cart_item|
      @order_details = OrderDetail.new
      @order_details.order_id = order.id
      @order_details.item_id = cart_item.item.id
      @order_details.tax_included_price = cart_item.item.tax_included_price
      @order_details.amount = cart_item.amount
      @order_details.status = 0
      @order_details.save!
    end

    CartItem.destroy_all
    redirect_to complete_orders_path
  end

  def complete
  end

  def index
    @orders = current_customer.orders
    @order_details = OrderDetail.where(order_id: params[:id])
  end

  def show
    @orders = Order.all
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:payment_method, :postcode, :address, :name, :postage, :billing_amount, :customer_id, :order_status)
  end

  def cartitem_nill
    cart_items = current_customer.cart_items
    if cart_items.blank?
      redirect_to cart_items_path
    end
  end
end
