class Admin::HomesController < ApplicationController
  def top
    @orders = Order.all
    @items = Item.all
    @genres = Genre.all
  end
end
