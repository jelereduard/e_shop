class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
# before_action :admin_user, only: [:create, :edit, :destroy]
  
  def new
    @product = Product.new 
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def index
    # byebug
    @products = Product.all.paginate(page: params[:page], per_page: 16)
  end

  def show
    
  end

  def edit
    if !can?(:manage, @product)
      redirect_to root_url
    end
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end 

  def create
    @product = Product.new(product_params) 
    @product.category_id = params[:category_id]
    respond_to do |format|
      if @product.save 
        format.html { redirect_to @product, notice: 'Product was successfully created.' } 
        format.json { render :show, status: :created, location: @product } 
      else 
        format.html { render :new } 
        format.json { render json: @product.errors, status: :unprocessable_entity } 
        
      end
    end 
  end 


  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    flash[:success] = "Product deleted"
    redirect_back(fallback_location: dashboard_path)
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, :category_id, :image)
    end
    
end
