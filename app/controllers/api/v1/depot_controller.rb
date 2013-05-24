# coding: utf-8

class Api::V1::DepotController < Api::V1::BaseController

  #put /api/v1/depot
  def put_items
    handle_exceptions do
      unless validate(params[:data])
        head :bad_request
        return
      end

      data = params[:data]

      #рит/ венок "Аврора" 3.2.3

      data.each do |item|

        DEPOT.put()
        name = item[:name].split('"')[1]
        p = Product.find_by_name(name)
        item[:number]

      end


      render json: {:data => data}
    end
  end

private

  def handle_exceptions
    begin
      return yield
    rescue ArgumentError => e
      Rails.logger.info("[DepotController] got incorrect request " + e.to_s)
      head :bad_request
    rescue IOError => e
      Rails.logger.warn("[DepotController] could not get data " + e.to_s)
      head :internal_server_error
    end
  end


  def validate(data)
     unless data || data.kind_of?(Array)
       false
     else
       true
     end
  end


end