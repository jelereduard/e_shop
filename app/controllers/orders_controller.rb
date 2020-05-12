class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  def subregion_options
    render partial: 'subregion_select'
  end

  # def get_country_subregions
  #   @subregions = [["Please select a state", ""]]
  #   if params[:country] != 'Please select a country'
  #     carmen_country = Carmen::Country.coded(params[:country])
  #     if carmen_country.present?
  #       carmen_country.subregions.sort_by{|x| x.name}.map {|r| @subregions << [r.name, r.code]} 
  #     end
  #   end
  #   respond_to do |format|
  #     format.js
  #   end 
  # end

  # GET /orders/new
  def new
    @user = User.find_by(id: current_user.id)
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_id, :status, :user_id, :delivery_method, :delivery_name, :delivery_phone, :billing_country, :billing_region, :billing_city, :billing_address)
    end
end
