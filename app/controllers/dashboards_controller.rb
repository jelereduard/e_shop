class DashboardsController < ApplicationController
  before_action :is_admin
  def dashboard
    @categories=Category.all
    @products=Product.all
    @carts=Cart.all
  end

  def is_admin
    if not current_user.admin?
      redirect_to root_path
    end
  end
end
