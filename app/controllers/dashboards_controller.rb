class DashboardsController < ApplicationController
  before_action :authorization
  def dashboard
    @categories=Category.all
    @products=Product.all
    @carts=Cart.all
  end

  def authorization
    if !can? :edit, [@categories, @products, @carts]
      redirect_to root_path
    end
  end
end
