class ProductsController < ApplicationController
  
# before_action :admin_user, only: [:create, :edit, :destroy]
  
  def new
  end

  def index
    @products = Product.all
  end

  def edit
  end

  def create
  end

  def destroy
    @product.destroy
    flash[:success] = "Product deleted"
    redirect_back(fallback_location: root_url)
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).premit(:name, :price, :description, :image)
    end
    
end
