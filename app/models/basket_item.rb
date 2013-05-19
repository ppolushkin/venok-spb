class BasketItem < ActiveRecord::Base
#  tmp
  belongs_to :product
  belongs_to :basket
end
