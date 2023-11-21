class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to request.referrer
    else
      render :show
    end
  end
  
  private
end
