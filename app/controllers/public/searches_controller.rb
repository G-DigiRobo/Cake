class Public::SearchesController < ApplicationController
  def search
    @items = Item.looks(params[:word])
  end
end
