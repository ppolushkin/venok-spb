# coding: utf-8
class Basket < ActiveRecord::Base

  has_many :basket_items, :dependent => :destroy

  def set_number_of_product(product, count)
    current_item = basket_items.where(:product_id => product.id).first
    if current_item
      current_item.count = count
    else
      current_item = BasketItem.new(:product_id=>product.id)
      current_item.count = count
      basket_items << current_item
    end
    current_item.save
    save
  end

  def get_product_count(product)
    current_item = basket_items.where(:product_id => product.id).first
    if current_item
      current_item.count
    else
      0
    end
  end

  def get_summary_price()
    price = 0
    for item in basket_items
      price+=item.product.price * item.count
    end
    price
  end

  def print_sub_statistic(type)
    distinct_count = 0
    summary_count = 0
    summary_price = 0
    for item in basket_items
      if(item.product.type?(type))
        if(item.count>0)
          distinct_count+=1
        end
        summary_count+=item.count
        summary_price+=item.product.price * item.count
      end
    end
    distinct_count.to_s + " наименований,<br>" + summary_count.to_s + " товаров,<br>" + sprintf("%u р", summary_price)
  end

end
