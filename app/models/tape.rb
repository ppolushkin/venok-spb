# coding: utf-8
class Tape < ActiveRecord::Base
  attr_accessible :count, :text, :color, :product_id

  belongs_to :basket

  def product_article
    p = Product.find_by_id(product_id)
    if p
      return p.article
    end

    nil
  end

end
