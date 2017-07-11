class CartsController < ApplicationController
  before_action :authenticate_user!

  def index

  end

  def show

  end

  def create
  end

  def update
    @cart = Cart.find(params[:id])
  end

  def edit
    @cart = Cart.find(params[:id])
  end

  def destroy
    cart = Cart.find(params[:id])
  end

  private
  end

end