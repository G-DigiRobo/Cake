class Admin::SearchesController < ApplicationController
  def search
    @range = params[:range]
    @customers = Customer.looks(params[:word])
  end
end
