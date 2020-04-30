# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    can [:read, :edit, :destory], Cart do |cart|
      cart.id == session[:cart_id]
    end
    cannot [:create, :edit, :destroy], Category
    cannot :crud, User
    cannot [:create, :edit, :destroy], Product
    cannot :curd, OrderItem
    
    if user.present?
      # can [:read, :update, :destory], User, user_id: user.id
      can :crud, Cart do |cart|
        cart.user_id == user.id
      end
      cannot [:create, :edit, :destroy], Category
      can :crud, User, user_id: user.id
      cannot [:create, :edit, :destroy], Product
      cannot :curd, OrderItem
    end
    if user.admin?
        # can :read, :all
        # can [:create, :edit, :destroy], Cart, user_id: user.id
        can :manage, :all
    end
    
  end
end
