class Order < ApplicationRecord
  has_many :order_items
  has_many :products, through: :order_items
  # belongs_to :user, class_name: "user", foreign_key: "user_id"
end
