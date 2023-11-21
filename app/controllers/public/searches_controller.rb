class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @items = Item.looks(params[:word])
  end
end
