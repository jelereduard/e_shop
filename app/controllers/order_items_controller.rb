class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy, :decrement_quantity, :increment_quantity]
  
  def index
    @order_items = OrderItem.all
  end

  def show
  end

  def new
    @order_item = OrderItem.new
  end

  def create
    if @cart.nil?
      @cart = Cart.create(user_id: current_user.id)
    end 
    product = Product.find(params[:product_id])
    @order_item = @cart.add_product(product)
    if @order_item == "Out of stock"
      respond_to do |format|
        format.html { render :new }
        format.json { render json: {status: 'failed', product_id: product.id}}
      end
    else
      begin
        @order_item.save
        respond_to do |format|
          format.json {render json: {status: 'success'}}
        end
      rescue
        respond_to do |format|
          format.html { render :new }
          format.json { render json: {status: 'failed', product_id: product.id}}
        end
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
    if !session[:cart_id].nil?
      @cart = Cart.find(session[:cart_id])
    else
      @cart = Cart.find_by(user_id: current_user.id)
    end
    @product = @order_item.product
    @quantity = @product.stock + @order_item.quantity
    @product.update_attributes(stock: @quantity)
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to cart_path(@cart), notice: 'Product was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def decrement_quantity
    if @cart.present? && @order_item.present?
      @product = @order_item.try(:product)
      begin
        if @order_item.quantity > 1
          @order_item.decrement!(:quantity)
        else
          @order_item.destroy
        end
        @product.update_attributes(stock: @product.stock + 1) if @product.present?
        respond_to do |format|
          format.html { redirect_to cart_path(@cart), notice: 'Item was successfully removed.' }
          format.json { head :no_content }
        end
      rescue
        respond_to do |format|
          format.html { redirect_to cart_path(@cart), notice: 'Could not remove item.' }
          format.json { head :no_content }
        end
      end
    end
  end

  def increment_quantity
    if @cart.present? && @order_item.present?
      begin
        @product = @order_item.product
        if @product.stock > 0
          @order_item.increment!(:quantity)
          @product.update_attributes(stock: @product.stock - 1)
        end
        respond_to do |format|
          format.html { redirect_to cart_path(@cart), notice: 'Item was successfully added.' }
          format.json { head :no_content }
        end
      rescue
        respond_to do |format|
          format.html { redirect_to cart_path(@cart), notice: 'Could not add item.' }
          format.json { head :no_content }
        end
      end
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