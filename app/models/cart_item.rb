class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item
 
def line_total
  item.price * amount * 1.1
end

def tax_price
  item.price * 1.1
end


  
end
