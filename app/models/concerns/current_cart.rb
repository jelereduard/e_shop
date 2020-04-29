module CurrentCart

    def set_cart
        if !current_user.nil?
            if session[:cart_id].present?
                @cart = Cart.find(session[:cart_id])
                if !@cart.order_items.first.nil?
                    if @cart.user_id.nil?
                        Cart.where(user_id: current_user.id).last.destroy
                        @cart.update_attributes(user_id: current_user.id)
                    end
                else
                    if @cart.user_id.nil?
                        @cart.destroy
                    end
                end
            end

            @cart = Cart.where(user_id: current_user.id).last
            if @cart.nil?
                @cart = Cart.create(user_id: current_user.id)
                session[:cart_id] = @cart.id
            end

        else
            if session[:cart_id].present?
                if !Cart.all.last.nil?
                    @cart = Cart.find(session[:cart_id])
                else
                    @cart=Cart.create
                    session[:cart_id]=@cart.id
                end
            else
                @cart = Cart.create
                session[:cart_id] = @cart.id
            end
        end
    rescue ActiveRecord::RecordNotFound
        @cart = Cart.create(user_id: current_user.id)
        session[:cart_id] = @cart.id
    end

end