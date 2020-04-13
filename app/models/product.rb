class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :category, optional: true


  validates :name, :price, :description, presence: true
  validates :description, length: {maximum:500, too_long: "%{count} characters is the maximum allowed!"}
  validates :name, length: {maximum: 100}
  validates :price, numericality: {only_decimal: true}, length: {maximum: 5}

# CATEGORY = %W{ Burger Pasta Soup }



private
# Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end