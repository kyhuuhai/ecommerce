class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include ApplicationHelper

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to root_path
  end

  def current_cart
    unless @current_cart
      if current_user
        @current_cart = current_user.carts.first || Cart.create(user: current_user)
      elsif session[:current_cart]
        @current_cart = Cart.where(id: session[:current_cart]).first || Cart.create
      else
        @current_cart = Cart.create
      end
    end
    return @current_cart
  end

  def load_session_cart_details
    @cart_detail_session = session[:current_cart] ? session[:current_cart] : Array.new
  end
end
