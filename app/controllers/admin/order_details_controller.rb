class Admin::OrderDetailsController < ApplicationController
  
  def update
    @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      flash[:notice] = "製作ステータスを更新しました"
      redirect_to request.referrer
    else
      render :request.referrer
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:status)
  end

end
