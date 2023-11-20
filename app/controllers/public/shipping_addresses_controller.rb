class Public::ShippingAddressesController < ApplicationController
  before_action :find_address, only: [:edit, :update, :destroy]
   
    def new
      @shipping_address = ShippingAddress.new
    end
    
    def index
      @shipping_addresses = current_customer.shipping_addresses 
    end
  
    def edit
    end
    
    def create
      @shipping_address = ShippingAddress.new(shipping_address_params)
      @shipping_address.customer = current_customer
      
      if @shipping_address.save
        redirect_to @shipping_address, notice: 'Shipping address was successfully created.'
      else
        render :new
      end
    end
 
    def update
      if @shipping_address.update(shipping_address_params)
        redirect_to @shipping_address, notice: 'Shipping address was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @shipping_address.destroy
      redirect_to shipping_addresses_url, notice: 'Shipping address was successfully destroyed.'
    end
    
  private
    def find_address
      @shipping_address = current_customer.shipping_addresses.find(params[:id]) 
    end
    
    def shipping_address_params
      params.require(:shipping_address).permit(:recipient_name, :address_line_1, :address_line_2, :city, :state, :postal_code, :country)
    end
end