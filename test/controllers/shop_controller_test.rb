require 'test_helper'

class ShopControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_path # get 'shop_index_url'
    assert_response :success
  end

end
