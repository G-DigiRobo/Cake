class Public::SearchesController < ApplicationController
  def search
    @genres = Genre.all
    @range = params[:range]
    @items = Item.looks(params[:word])
  end
end
