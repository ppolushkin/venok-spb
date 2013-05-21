# coding: utf-8
class Basket < ActiveRecord::Base

  has_many :basket_items, :dependent => :destroy
  belongs_to :order

  def put(product_id, count)
    current_item = basket_items.where(:product_id => product_id).first
    if current_item
      current_item.count = count
    else
      current_item = BasketItem.new(:product_id=>product_id)
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
    basket_items.each do |item|
      count+=item.count
    end
    count
  end

  def summary_price()
    price = 0
    basket_items.each do |item|
      price+=item.product.retail_price * item.count
    end
    price
  end


end
