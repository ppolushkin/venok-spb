
class Api::V1::BaseController < ActionController::Base

  respond_to :json

  before_filter :current_basket, :current_admin

  def basket
    @basket
  end

  def admin
    @admin
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

  def current_admin
    if session[:admin_email]
      @admin = Admin.find_by_email(session[:admin_email])
    end
  end

end