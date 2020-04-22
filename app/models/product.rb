class Product < ApplicationRecord
  before_destroy :not_referenced_by_any_order_item
  mount_uploader :image, ImageUploader
  belongs_to :category, optional: true
  has_many :order_items, class_name: "order_item", foreign_key: "reference_id"
  default_scope -> { order(created_at: :desc) }

  validates :name, :price, :description, presence: true
  validates :description, length: {maximum:500, too_long: "%{count} characters is the maximum allowed!"}
  validates :name, length: {maximum: 100}
  validates :price, numericality: {only_decimal: true}, length: {maximum: 5}
  validate  :picture_size
# CATEGORY = %W{ Burger Pasta Soup }



private
# Validates the size of an uploaded image.
  def picture_size
    if image.size > 5.megabytes
      errors.add(:image, "should be less than 5MB")
    end
  end

  def not_referenced_by_any_order_item
    unless order_items.empty?
      errors.add(:base, "Order items present")
      throw :abort
    end
  end
end