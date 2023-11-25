class FormOrderNew
  include ActiveModel::Model

  attr_accessor :payment_method, :postcode, :address, :name, :postage, :billing_amount, :customer_id, :order_status, :address_id, :select_address

  validates :postcode, presence: true
  validates :address, presence: true
  validates :name, presence: true

  def to_model
    Order.new(
      payment_method: payment_method,
      postcode: postcode,
      address: address,
      name: name,
      postage: postage,
      billing_amount: billing_amount,
      customer_id: customer_id,
      order_status: order_status
    )
  end

  def save
    return false if invalid?
    order = to_model
    unless order.save
      order.errors.each do |attribute, message|
        errors.add(attribute, message)
      end
      return false
    end

    true
  end

  def payment_method_i18n
    I18n.t("enums.order.payment_method.#{payment_method}")
  end
end