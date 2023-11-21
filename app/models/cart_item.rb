class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    item.with_tax_price * amount
  end
end
