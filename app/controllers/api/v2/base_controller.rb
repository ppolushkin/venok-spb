
class Api::V2::BaseController < ActionController::Base

  respond_to :json

  before_filter :current_basket, :current_admin

  def current_basket
    @current_basket
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
    @current_basket = basket
  end

  def current_admin
    if session[:admin_email]
      @admin = Admin.find_by_email(session[:admin_email])
    end
  end

  def authorize
    unless session[:admin]
      head :forbidden
      return
    end
  end

  def handle_exceptions
    begin
      return yield
    rescue ArgumentError => e
      Rails.logger.info("V2 API got incorrect request " + e.to_s)
      head :bad_request
    rescue IOError => e
      Rails.logger.warn("V2 API could not get data " + e.to_s)
      head :internal_server_error
    end
  end



end