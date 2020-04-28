class OrderItem < ApplicationRecord
    belongs_to :product
    belongs_to :cart

    def total_price
        product.price.to_f * quantity.to_i
    end
end
