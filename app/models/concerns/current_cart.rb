module CurrentCart

    def set_cart
        if current_user.present?
            if session[:cart_id].present?
                @cart = Cart.find(session[:cart_id])
                if !@cart.order_items.first.nil? && @cart.user_id.nil?
                    if Cart.where(user_id: current_user.id).last.present?
                        Cart.where(user_id: current_user.id).last.destroy
                    end
                    @cart.update_attributes(user_id: current_user.id)
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
                begin
                    @cart = Cart.find(session[:cart_id])
                rescue
                    @cart = Cart.create
                    session[:cart_id] = @cart.id
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