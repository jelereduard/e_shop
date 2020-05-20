class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  # belongs_to :user, class_name: "user", foreign_key: "user_id"
  validates :payment_method, :delivery_method, :delivery_name, :delivery_phone, :billing_country, :billing_region, :billing_city, :billing_address, presence: true

  def total_price
    order_items.to_a.sum { |item| item.total_price }
  end
end
 