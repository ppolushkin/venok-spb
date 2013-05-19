# coding: utf-8
class Api::V1::BasketController < Api::V1::BaseController

  #get /api/v1/basket
  def index

    handle_exceptions do
      count = basket.summary_count
      price = sprintf("%u р", basket.summary_price)

      render json: {:count => count, :price => price}
    end
  end

  private

  def handle_exceptions
    begin
      return yield
    rescue ArgumentError => e
      Rails.logger.info("[BasketController] got incorrect request " + e.to_s)
      head :bad_request
    rescue IOError => e
      Rails.logger.warn("[BasketController] could not get data " + e.to_s)
      head :internal_server_error
    end
  end


end