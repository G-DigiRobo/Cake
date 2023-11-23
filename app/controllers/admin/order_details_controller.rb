class Admin::OrderDetailsController < ApplicationController
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      redirect_to admin_order_detail_path(@order_detail), notice: '制作ステータスが更新されました。'
    else
      render :admin_order_path
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:status)
  end

end
