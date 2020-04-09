require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  def setup
    @product=Product.new(name: "Burger", price: 15.99, description: "simple burger")
  end

  test "name should be present" do
    @product.name = "     "
    assert_not @product.valid?
  end



end
