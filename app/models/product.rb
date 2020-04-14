class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category, optional: true
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
end