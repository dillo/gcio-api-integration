# this test for now does NOT require a database connection
# require "test_helper"

class ProductFlowsTest < ActionDispatch::IntegrationTest

    test "can get fake_store products" do
      get "/products.json?" + ProductsController::get_fake_store_param
    
      assert_equal "index", @controller.action_name
      
      assert_equal 200, status

      # correct IF doing a redirect, but not after rest-client handling
      # assert_equal @response.get_header("location"), ProductsController::get_fake_store_products_URI
    end
end # end class
