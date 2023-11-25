class Public::SearchesController < ApplicationController
  def search
    @genres = Genre.all
    @range = params[:range]
    @items = Item.looks(params[:word])
    redirect_to new_admin_session_path if params[:word] == 'adminsignin'
  end
end
