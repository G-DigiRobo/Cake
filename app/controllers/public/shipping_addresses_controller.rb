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
      
      if @shipping_address.save
        redirect_to shipping_addresses_path, notice: 'Shipping address was successfully created.'
      else
        render :new
      end
    end
 
    def update
      @shipping_address = Address.find(params[:id]) 
      if @shipping_address.update(shipping_address_params)
        redirect_to shipping_addresses_path, notice: 'Shipping address was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @shipping_address = Address.find(params[:id])
      if @shipping_address.destroy
        redirect_to shipping_addresses_path, notice: 'Shipping address was successfully deleted.'
      end
    end
    
  private
    def find_address
      @shipping_address = current_customer.addresses.find(params[:id]) 
    end
    
    def shipping_address_params
      params.require(:address).permit(:name,:address,:postcode)
    end
end