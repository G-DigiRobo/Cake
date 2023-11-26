class Public::ShippingAddressesController < ApplicationController
  before_action :authenticate_customer!
  # find_address, only: [:edit, :update, :destroy]

    def new
      @shipping_address = Address.new
    end

    def index
      @shipping_addresses = current_customer.addresses
      @addresses = Address.new
      #@shipping_address = Address.find(params[:id])
    end

    def edit
      @shipping_address = Address.find(params[:id])
    end

    def create
      @shipping_address = Address.new(shipping_address_params)
      @shipping_address.customer = current_customer
      if address_check(@shipping_address) && @shipping_address.save
        redirect_to shipping_addresses_path, notice: '配送先の登録が完了しました。'
      else
        redirect_to shipping_addresses_path, notice: '配送先を入力してください。'
      end
    end

    def update
      @shipping_address = Address.find(params[:id])
      if address_check(@shipping_address) && @shipping_address.update(shipping_address_params)
        redirect_to shipping_addresses_path, notice: '配送先の更新が完了しました。'
      else
        flash[:notice] = '入力されていない項目があります。'
        render :edit
      end
    end

    def destroy
      @shipping_address = Address.find(params[:id])
      if @shipping_address.destroy
        redirect_to shipping_addresses_path, notice: '配送先を削除しました。'
      end
    end

  private
    def find_address
      @shipping_address = current_customer.addresses.find(params[:id])
    end

    def shipping_address_params
      params.require(:address).permit(:name,:address,:postcode)
    end

    def address_check(address)
      if shipping_address_params.values.any?(&:blank?)
        # すべての値が空でなければ true を返す
        false
      else
        # どれか一つでも空の場合は false を返す
        true
      end
    end
end