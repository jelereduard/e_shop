class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  
  def new
    @product = Product.new 
    @categories = Category.all.map{|c| [ c.name, c.id ] }
  end

  def index
    if params[:qtitle]
      if params[:qtitle] != ""
        @search_results_products = Product.all.where("lower(name) LIKE lower(?)",'%'+params[:qtitle]+'%').paginate(page: params[:page], per_page: 16)
          
        if @search_results_products.length > 0          
            respond_to do |format|
              format.js { render partial: 'search-results' }
              format.html {render partial: 'results'}
            end
          else
            @products = Product.all.paginate(page: params[:page], per_page: 16)
            respond_to do |format|
              format.js { render partial: 'show-index' }
            end
          end

      else
        @products = Product.all.paginate(page: params[:page], per_page: 16)
        respond_to do |format|
          format.js { render partial: 'show-index' }
        end
      end
    else
      @products = Product.all.paginate(page: params[:page], per_page: 16)
      
    end
      respond_to do |format|
        format.js 
        format.html 
      end
    # render :js => "window.location = '/products?qtitle=#{params[:qtitle]}'"
    
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
      params.require(:product).permit(:name, :price, :description, :category_id, :image, :stock, :qtitle)
    end
    
end
