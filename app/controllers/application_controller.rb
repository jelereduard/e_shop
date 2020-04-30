class ApplicationController < ActionController::Base
  include CurrentCart
  before_action :set_cart

  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:first_name, :last_name)
  end

end
