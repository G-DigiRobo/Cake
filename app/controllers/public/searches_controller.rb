class Public::SearchesController < ApplicationController
  def search
    @genres = Genre.all
    @range = params[:range]
    @items = Item.looks(params[:word])
    if params[:word] == 'adminsignin'
      redirect_to new_admin_session_path
    end
  end
end
