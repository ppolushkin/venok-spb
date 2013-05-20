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

  #put /api/v1/basket
  def put
    handle_exceptions do
      if params[:id] == nil || params[:count] == nil || !is_number?(params[:count].to_s) || params[:count].to_i < 0
        head :bad_request
        return
      end

      basket.put(params[:id].to_i, params[:count].to_i)
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


  def is_number?(string)
    true if Float(string) rescue false
  end
end