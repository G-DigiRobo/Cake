class Admin::SearchesController < ApplicationController
  def search
    @genres = Genre.all
    @range = params[:range]
    @customers = Customer.looks(params[:word])
    @items = Item.looks(params[:word])
  end
end
