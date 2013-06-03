# coding: utf-8
class Api::V2::BasketController < Api::V2::BaseController

  #get /api/v2/current_basket/summary
  def get_current_basket_summary
      count = current_basket.summary_count
      price = sprintf("%u р", current_basket.summary_price)

      render json: {:id => current_basket.id, :count => count, :price => price}    
  end

  #get /api/v2/current_basket
  def get_current_basket
      current_basket
      basket_items = []
      current_basket.basket_items.each() do |bi|
        basket_items << {
          :id => bi.id, 
          :product => {
            :id => bi.product.id, 
            :name => bi.product.name, 
            :retail_price => bi.product.retail_price 
            }, 
          :count => bi.count
        }
      end  
      render json: {:id => current_basket.id, :basket_items => basket_items}    
  end

end
