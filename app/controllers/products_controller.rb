require 'rest-client'

class ProductsController < ActionController::API
  before_action :set_product, only: [:show, :update, :destroy]

  @@fake_store_param = "fake_store"
  @@fake_store_products_URI = "https://fakestoreapi.com/products/"
  @@price_range_delimiter = ","


  @filtered_by_category = false
  
  def self.get_fake_store_param
    @@fake_store_param
  end
  
  def self.get_fake_store_products_URI
    @@fake_store_products_URI
  end
  
  # GET /products
  # /products?fake_store
  # /products?fake_store&category=electronics
  # /products?fake_store&category=electronics&price=100,200
  def index
    if request.parameters.has_key? @@fake_store_param

      # OK to redirect IF no category or price in the request.parameters
      # note the changed handling will affect the test code; 
      # new logic w/rest-client means we get HTTP 204 No Content back
      # redirect_to route_to_fake_store request.parameters

      fake_store_products = JSON.parse( RestClient.get route_to_fake_store request.parameters )

      # if we filter by price, we must also be passing a category per requirements
      # price=100,200
      if @filtered_by_category && (request.parameters.has_key? "price" )
        price_value = request.parameters[:price]
        fake_store_products =  filter_on_price_range fake_store_products, price_value
      end

      render json: fake_store_products
    else
      @products = Product.all
      render json: @products
    end
  end
    
  # return fake_store URI based on request parameters
  def route_to_fake_store request_params
        fake_store_url = @@fake_store_products_URI
        category_value = ""
        category_URI_append = ""
        if request_params.has_key? "category"
          @filtered_by_category = true
          category_value += request_params[:category]
          # some categories are men's clothing, women's clothing
          category_value = URI.escape category_value
          puts "URI-encloded category is " + category_value
          category_URI_append += "category/" + category_value
          fake_store_url += category_URI_append
        end
          fake_store_url
  end

  # input is json from fakestoreapi products, price range string
  # already filtered by category
  # return altered json
  def  filter_on_price_range product_json, price_range
      puts "the price range is " + price_range

     # TO DO: Require the range to be lowest, highest, 
     # OR add logic to accept highest, lowest

      range = price_range.split @@price_range_delimiter

      lowest_price = range[0].to_f 
      highest_price = range[1].to_f

      # remove JSON product objects not in price range, inclusive
      # HOW could 999.99 price slip thru when price_range was 100,245.99
      # also - WHY is the FINAL electroncs item NOT deleted here??
      # an artifact of recount of array once other items removed  IS LIKELY
      #
      # so loop to FLAG an item for deletion BY INDEX;
      # then delete per index

      deletion_indices = Array.new(product_json.count)
      # index of a deleted product
      del_i = 0
      # index of a product
      item_i = 0

      product_json.each { |product| 

        the_price = product["price"].to_f
        puts "THE PRICE: " + the_price.to_s

        if the_price > highest_price
          puts "TOO HIGH"
        end

        if the_price < lowest_price
          puts "TOO LOW"
        end

        if the_price < lowest_price
          deletion_indices[del_i] = item_i
          del_i += 1
        elsif the_price > highest_price
          deletion_indices[del_i] = item_i
          del_i += 1         
        end

        item_i += 1
      }

      j = 0
      while deletion_indices[j] != NIL
        product_json.delete product_json[j]
        j += 1
      end
      # product_json.delete product

      product_json
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

