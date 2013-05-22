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

  def full_order_price
    r = 0
    if basket
      r+=basket.summary_price
    end
    if delivery?
      r+=400
    end
    r
  end

  def formatted_full_order_price
    sprintf("%u р", full_order_price)
  end

  def email_exist?
    !self.email.empty?
  end

private

  def assign_basket
    if basket_id
      self.basket=Basket.find basket_id
    end
  end

end
