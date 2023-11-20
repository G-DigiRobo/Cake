class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = current_customer
  end

  def confirm
    @customer = current_customer
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "変更を保存しました"
      redirect_to customer_path
    else
      render :edit
    end
  end

  def withdrawal
    @customer = current_customer
    if @customer.update(is_active: false)
      sign_out @customer
      flash[:notice] = "退会しました"
      redirect_to root_path
    else
      render :confirm
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :telephone_number, :email)
  end

end
