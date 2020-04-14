class DashboardsController < ApplicationController
  def dashboard
    @categories=Category.all
    @products=Product.all
  end
end
