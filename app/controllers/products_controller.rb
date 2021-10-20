require 'rest-client'

class ProductsController < ActionController::API
  before_action :set_product, only: [:show, :update, :destroy]

  @@fake_store_param = "fake_store"
  @@fake_store_products_URI = "https://fakestoreapi.com/products/"
  
  def self.get_fake_store_param
    @@fake_store_param
  end
  
  def self.get_fake_store_products_URI
    @@fake_store_products_URI
  end
  
     # GET /products
  def index
      if request.parameters.has_key? @@fake_store_param

        # OK to redirect IF no category or price in the request.parameters
        # note the changed handling will affect the test code; 
        # new logic w/rest-client means we get HTTP 204 No Content back
        # redirect_to route_to_fake_store request.parameters

        fake_store_products = JSON.parse( RestClient.get route_to_fake_store request.parameters )
        render json: fake_store_products
      else
        @products = Product.all
        render json: @products
      end
    end
    
  # return fake_store URI based on request parameters
  def route_to_fake_store request_params
        fake_store_url = @@fake_store_products_URI
        # get the category name-value pair
        category_value = ""
        category_URI_append = ""
        if request_params.has_key? "category"
          category_value += request_params[:category]
          # some categories are men's clothing, women's clothing
          category_value = URI.escape category_value
          puts "URI-encloded category is " + category_value
          category_URI_append += "category/" + category_value
          fake_store_url += category_URI_append
        end
          fake_store_url
  end

  # GET /products/1
  def show
    if request.parameters.has_key? @@fake_store_param
      request_id = request.parameters[:id];
      puts "YES " + @@fake_store_param + " product #" + request_id
      redirect_to @@fake_store_products_URI + request_id
    else
      render json: @product
    end
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :price, :category, :description, :image)
    end
end
