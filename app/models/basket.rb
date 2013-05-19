# coding: utf-8
class Basket < ActiveRecord::Base

  has_many :basket_items, :dependent => :destroy

  def put(product, count)
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

  def count(product)
    current_item = basket_items.where(:product_id => product.id).first
    if current_item
      current_item.count
    else
      0
    end
  end

  def summary_count()
    count = 0
    for item in basket_items
      price+=item.count
    end
    count
  end

  def summary_price()
    price = 0
    for item in basket_items
      price+=item.product.price * item.count
    end
    price
  end


end
