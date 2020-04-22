module CurrentCart

    def set_cart
        @cart = Cart.where(user_id: current_user.id).last
    rescue ActiveRecord::RecordNotFound
        @cart = Cart.create(user_id: current_user.id)
        session[:cart_id] = @cart.id
    end

end