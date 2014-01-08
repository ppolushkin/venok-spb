# coding: utf-8
class Api::V1::BasketController < Api::V1::BaseController

  #get /api/v1/basket
  def index

    handle_exceptions do
      count = basket.summary_count
      price = sprintf("%u р", basket.summary_price)
      availiable = basket.is_items_availiable

      render json: {:id => basket.id, :count => count, :price => price, :availiable => availiable}
    end
  end

  #get /api/v1/basket/product/:id
  def product_details
    if params[:id] == nil || !is_number?(params[:id].to_s)
      head :bad_request
      return
    end

    handle_exceptions do
      item = basket.basket_items.find_by_product_id(params[:id].to_i)
      if item
        common_price = sprintf("%u р", item.count * item.product.retail_price)
        render json: {:name => item.product.name, :price => item.product.formatted_retail_price, :count => item.count, :common_price => common_price}
      else
        head :bad_request
      end
    end
  end

  #delete /api/v1/basket/product/:id
  def delete_product
    if params[:id] == nil || !is_number?(params[:id].to_s)
      head :bad_request
      return
    end

    handle_exceptions do
      item = basket.basket_items.find_by_product_id(params[:id].to_i)
      if item
        item.delete
        render json: {:product_id => params[:id]}
      else
        head :bad_request
      end
    end
  end

  #put /api/v1/basket/product
  def put_product
    handle_exceptions do
      if params[:id] == nil || params[:count] == nil || !is_number?(params[:count].to_s) || params[:count].to_i < 0
        head :bad_request
        return
      end

      basket.put_product(params[:id].to_i, params[:count].to_i)
      count = basket.summary_count
      price = sprintf("%u р", basket.summary_price)

      render json: {:count => count, :price => price}
    end
  end

  #put /api/v1/basket/tape
  def put_tape
    handle_exceptions do
      if  params[:count] == nil || !is_number?(params[:count].to_s) || params[:count].to_i < 0 ||
         params[:product_id] == nil || !is_number?(params[:product_id].to_s)
        head :bad_request
        return
      end

      basket.put_tape(params[:product_id].to_i, params[:color], params[:text], params[:count].to_i)

      render json: {:status => 'ok'}
    end
  end

  #get /api/v1/basket/tape/:id
  def get_tape
    if params[:id] == nil || !is_number?(params[:id].to_s)
      head :bad_request
      return
    end

    handle_exceptions do
      item = basket.tapes.find_by_product_id(params[:id].to_i)
      if item
        render json: {:count => item.count, :text => item.text, :color => item.color}
      else
        render json: {:count => 0}
      end
    end
  end

  #delete /api/v1/basket/tape/:id
  def delete_tape
    if params[:id] == nil || !is_number?(params[:id].to_s)
      head :bad_request
      return
    end

    handle_exceptions do
      item = basket.tapes.find_by_product_id(params[:id].to_i)
      if item
        item.delete
        render json: {:product_id => params[:id]}
      else
        head :bad_request
      end
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