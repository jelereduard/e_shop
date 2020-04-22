class OrderItemsController < ApplicationController
    include CurrentCart
    before_action :set_order_item, only: [:show, :edit, :update, :destroy]
    before_action :set_cart, only: [:create]
    def index
        @order_items = OrderItem.all
    end
    def show
    end
    def new
        @order_item = OrderItem.new
    end
    def create
        product = Product.find(params[:product_id])
        
        
        @order_item = @cart.add_product(product)
        respond_to do |format|
            if @order_item.save
              format.html { redirect_to @order_item.cart, notice: 'Product was successfully added to current cart! '+ "#{@cart.id}" }
              format.json { render :show, status: :created, location: @order_item }
            else
              format.html { render :new }
              format.json { render json: @order_item.errors, status: :unprocessable_entity }
            end
          end
    end
    def edit
    end
    def update
        respond_to do |format|
            if @order_item.update(order_item_params)
                format.html { redirect_to @order_item, notice: 'Order item was successfully updated.' }
                format.json { render :show, status: :ok, location: @order_item }
            else
                format.html { render :edit }
                format.json { render json: @order_item.errors, status: :unprocessable_entity }
            end
        end
    end
    def destroy
        @cart = Cart.find(session[:cart_id])
        @order_item.destroy
        respond_to do |format|
            format.html { redirect_to cart_path(@cart), notice: 'Item was successfully removed.' }
            format.json { head :no_content }
        end
    end
    private
    def set_order_item
        @order_item=OrderItem.find(params[:id])
    end
    def order_item_params
        params.require(:order_item).permit(:product_id)
    end
end