# coding: utf-8

class Order < ActiveRecord::Base
  attr_accessible :address, :basket_id, :delivery, :email, :full_name, :notes, :phone
  has_one :basket, :dependent => :destroy

  before_create :assign_basket
  before_update :assign_basket


  #t.integer  "basket_id"
  #t.string   "full_name"
  #t.string   "phone"
  #t.string   "email"
  #t.string   "address"
  #t.boolean  "delivery"
  #t.text     "notes"

  validates :full_name, :phone, :presence => true
  validates :email, :email => true, :if => :email_exist?
  validates :address, :presence => true, :if => :delivery?

  # Deprecated
  def full_order_price
    r = 0
    if basket
      r+=basket.summary_price
    end
    if delivery?
      r+=500
    end
    r
  end

  def email_exist?
    !self.email.empty?
  end

  def new?
    self.state == 'new'
  end

  def verify
    ActiveRecord::Base.transaction do
      self.basket.basket_items.each do |bi|
        DEPOT.hold(bi.product.id, bi.count)
      end
      self.state = 'verified'
      self.save
    end
  end


private

  def assign_basket
    if basket_id
      self.basket=Basket.find basket_id
    end
  end

end
