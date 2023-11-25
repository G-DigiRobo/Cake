class Public::SearchesController < ApplicationController
  def search
    @genres = Genre.all
    @range = params[:range]
    @items = Item.looks(params[:word])
  end

  def genre_search
    @genre_id = params[:genre_id]
    @genres = Genre.all
    @range = params[:range]
    @items = Item.where(genre_id: @genre_id)
  end
end
