class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :amount, presence: true

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    item.tax_included_price * amount
  end
end
