class Admin::SearchesController < ApplicationController
  def search
    @genres = Genre.all
    @range = params[:range]
    @customers = Customer.looks(params[:word])
    @word = params[:word]
    @items = Item.looks(@word)
  end
end
