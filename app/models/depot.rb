class Depot < ActiveRecord::Base

  attr_accessible :name

  has_many :depot_items, :dependent => :destroy

  def put(product_id, count)
    return current_depot_item(product_id).put(count)
  end

  def hold(product_id, count)
    return current_depot_item(product_id).hold(count)
  end

  def unhold(product_id, count)
    return current_depot_item(product_id).unhold(count)
  end

  def remove_from_holded(product_id, count)
    return current_depot_item(product_id).remove_from_holded(count)
  end

  def remove(product_id, count)
    return current_depot_item(product_id).remove(count)
  end

  def availiable(product_id)
    return current_depot_item(product_id).availiable
  end

  def save_item(product_id, count, hold_count)
    di = current_depot_item(product_id)
    di.count = count
    di.hold_count = hold_count
    di.save
  end

private

  def current_depot_item(product_id)
    current_item = depot_items.where(:product_id => product_id).first
    unless current_item
      current_item = DepotItem.new(:product_id=>product_id, :count=>0, :hold_count=>0)
      depot_items << current_item
    end
    current_item.save
    save

    return current_item
  end

end
