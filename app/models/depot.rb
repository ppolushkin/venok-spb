class Depot < ActiveRecord::Base

  attr_accessible :name

  has_many :depot_items, :dependent => :destroy

  def put(product_id, count)
    current_item = depot_items.where(:product_id => product_id).first
    if current_item
      current_item.count = count
    else
      current_item = DepotItem.new(:product_id=>product_id)
      current_item.count = count
      current_item.hold_count = 0
      depot_items << current_item
    end
    current_item.save
    save
  end


end
