class BasketController < ApplicationController

  skip_before_filter :authorize

  # GET /basket
  def index
    @basket = current_basket
  end

  private

  def current_basket
    basket = Basket.find_by_id (session[:basket_id])
    unless basket
      basket = Basket.create
      session[:basket_id] = basket.id
    end
    @basket = basket
  end


end