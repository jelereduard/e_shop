class AddOrderDetailsToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :payment_method, :string
    add_column :orders, :delivery_method, :string
    add_column :orders, :delivery_name, :string
    add_column :orders, :delivery_phone, :string
    add_column :orders, :billing_country, :string
    add_column :orders, :billing_region, :string
    add_column :orders, :billing_city, :string
    add_column :orders, :billing_address, :string
  end
end
