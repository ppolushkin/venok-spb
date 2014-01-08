# coding: utf-8
class Basket < ActiveRecord::Base

  has_many :basket_items, :dependent => :destroy
  has_many :tapes, :dependent => :destroy
  belongs_to :order

  def put_product(product_id, count)
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

  def put_tape(product_id, color, text, count)
    tape = tapes.where(:product_id => product_id).first
    if tape
      tape.color = color if color
      tape.text = text if text
      tape.count = count
    else
      tape = Tape.new(:product_id => product_id)
      tape.color = color if color
      tape.text = text if text
      tape.count = count
      tapes << tape
    end
    tape.save
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
    tapes.each do |tape|
      count+=tape.count
    end
    count
  end

  def summary_price()
    price = 0
    basket_items.each do |item|
      price+=item.product.retail_price * item.count
    end
    tapes.each do |tape|
      price+=tape.count * 300
    end

    price
  end

  def formatted_summary_price
    sprintf("%u р", summary_price)
  end

  def is_items_availiable()
    basket_items.each do |item|
      if (DEPOT.availiable(item.product_id) < item.count)
        return false
      end
    end
    return true
  end


end
