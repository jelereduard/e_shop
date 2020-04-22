class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.string :product_id
      t.string :quantity
      t.string :cart_id
      t.string :order_id

      t.timestamps
    end
  end
end
