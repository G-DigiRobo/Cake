class Public::OrdersController < ApplicationController
  before_action :cartitem_nill,   only: [:new, :create]
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @confirm_order = Order.new
    if params[:order][:select_address] == "own_address"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
      render :confirm
    elsif params[:order][:select_address] == "registered_address"
      @address = Address.find(params[:order][:address_id])
      @order.postcode = @address.postcode
      @order.address = @address.address
      @order.name = @address.name
      render :confirm
    elsif params[:order][:select_address] == "new_address"
      if address_check(@order)
        render :confirm
      else
        render :new
      end
    end
  end

  def create
    order_params[:order_status] = order_params[:order_status].to_i
    order = Order.new(order_params)
    if order.save
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
    else
      render :new
    end
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

  def address_params
    params.require(:order).permit(:address, :postcode, :name)
  end

  def address_check(order)
    if address_params.values.any?(&:blank?)
      # すべての値が空でなければ true を返す
      false
    else
      # どれか一つでも空の場合は false を返す
      true
    end
  end

  def cartitem_nill
    cart_items = current_customer.cart_items
    if cart_items.blank?
      redirect_to cart_items_path
    end
  end
end
