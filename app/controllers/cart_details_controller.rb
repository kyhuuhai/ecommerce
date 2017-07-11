class CartDetailsController < ApplicationController
  before_action :current_cart
  before_action :load_cart_details, only: :destroy
  before_action :load_session_cart_details, only: [:create, :destroy]

  def index
    @cart_details = Cart_details.scoped
  end

  def show

  end

  def create
    cart_details = AddProductSessionService.new({product_id: params[:cart_detail][:product_id],
      cart_details: @cart_detail_session}).add_product
    respond_to do |format|
      if cart_details.include? params[:cart_detail][:product_id]
        format.json {render json: {status: "200", id: params[:cart_detail][:product_id]}}
      else
        format.json {render json: {status: "400"}}
      end
    end
  end

  def update
    @cart_details = Cart_details.find(params[:id])
  end

  def edit
    @cart_details = Cart_details.find(params[:id])
  end

  def destroy
    cart_details = AddProductSessionService.new({product_id: params[:id],
      cart_details: @cart_detail_session}).remove_product
    respond_to do |format|
      if !cart_details.include? params[:id]
        format.json {render json: {status: "200"}}
      else
        format.json {render json: {status: "400"}}
      end
    end
  end

  private

  def load_cart_details
    @cart_detail = CartDetail.find_by params[:id]
    unless @cart_detail
      redirect_to root_path
    end
  end

  def cart_details_params
    params.require(:cart_detail).permit :quantity, :product_id
  end
end
