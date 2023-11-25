class Public::SearchesController < ApplicationController
  def search
    @genres = Genre.all
    @range = params[:range]
    @word = params[:word]
    @items = Item.looks(@word).page(params[:page]).per(8)
    redirect_to new_admin_session_path if params[:word] == 'adminsignin'
  end

  def genre_search
    @genre_id = params[:genre_id]
    @genre = Genre.find_by(id: @genre_id)
    @genres = Genre.all
    @range = params[:range]
    @items = Item.where(genre_id: @genre_id).page(params[:page]).per(8)
  end
end
