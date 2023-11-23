class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
    is_updated = true
    if @order_detail.update(order_detail_params)
      if @order_detail.status == "under_manufacture"
        @order.update(order_status: "under_manufacture")
      end
      @order_details.each do |order_detail|
        if order_detail.status != "completion_of_manufacturing"
          is_updated = false
        end
      end
      if is_updated
        @order.update(order_status: "preparing_to_ship")
      end
    end
      redirect_to request.referrer
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:status)
  end

end
