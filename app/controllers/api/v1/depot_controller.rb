# coding: utf-8

class Api::V1::DepotController < Api::V1::BaseController

  before_filter :authorize, :except => [:get_availiable_count]

  #get /api/v1/depot/get_available_items/:id
  def get_available_items
    handle_exceptions do
      if params[:id] == nil || !is_number?(params[:id].to_s)
        head :bad_request
        return
      end

      render json: {:available => DEPOT.availiable(params[:id])}
    end
  end


  #put /api/v1/depot
  def put_items
    handle_exceptions do
      unless validate(params[:data])
        head :bad_request
        return
      end

      data = params[:data]

      data.each do |item|
        if item[:status] != 'loaded'
          p = DepotsHelper.find_product_by_name(item[:name])
          if p
            DEPOT.put(p.id, item[:number].to_i)
            item[:status]='loaded'
          else
            item[:status]='failed'
          end
        end
      end

      render json: {:data => data}
    end
  end

  #post /api/v1/depot
  def post_items
    handle_exceptions do
      unless validate(params[:data])
        head :bad_request
        return
      end

      data = params[:data]
      data.each do |item|
        p = DepotsHelper.find_product_by_article(item[:article])
        if p
          DEPOT.save_item(p.id, item[:count].to_i, item[:hold_count].to_i)
        end
      end
      render json: {:result => 'true'}
    end

  end

#get /api/v1/depot
def get_items
  all_items = DEPOT.depot_items.all
  depot_items = all_items.sort do |a, b|
    a.product.name <=> b.product.name
  end

  data = []
  i = 1
  depot_items.each do |di|
    data << {:index => i, :article => di.product.article, :name => di.product.name, :count => di.count, :hold_count => di.hold_count}
    i+=1
  end

  render json: {:data => data}
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