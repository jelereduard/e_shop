class Cart < ApplicationRecord
    
    has_many :order_items, dependent: :destroy

    def add_product(product)
        current_item = order_items.find_by(product_id: product.id)
        
        if current_item
          current_item.increment(:quantity)
        else
          current_item = order_items.build(product_id: product.id, cart_id: self.id)
        end
        current_item
    end

    def remove_product(product)
      current_item = order_items.find_by(product_id: product.id)

      if current_item.quantity > 1
        current_item.decrement(:quantity)
      else
        current_item.destroy
      end
    end
    
    def total_price
        order_items.to_a.sum { |item| item.total_price }
    end
end
