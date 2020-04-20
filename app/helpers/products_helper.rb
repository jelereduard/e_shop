module ProductsHelper

    def show_category(category)
        @cat=Category.find(category.id)
        @products = @cat.products.paginate(page: params[:page], per_page: 16)
    end
end
