class ProductsController < ApplicationController
  before_action :load_product, only: [:edit, :update, :show, :destroy]
  before_action :current_cart, only: :index
  before_action :load_session_cart_details, only: :index

  def index
    @products = Product.search params[:term]
    @categories = Category.all
    respond_to do |format|
      format.html
      format.json { @products }
    end
  end

  def show; end

  def new
    @product = Product.new
    @product.pictures.build
  end

  def edit; end

  def create
    @product = Product.new product_params
    if @product.save
      flash[:success] = "Tao Product Thanh Cong"
      redirect_to products_path
    else
      render :new
    end
  end

  def destroy
    if request.xhr?
      @products = Product.find(params[:ids])
      @products.map {|p| p.update_attributes(category_id: nil)}
      respond_to do |format|
        format.json{render json: {cate_id: params[:cate_id]}, status: "200"}
      end
    else
      if @product.destroy
        flash[:success] = "Xoa Product Thanh Cong"
        redirect_to products_path
      else
        flash[:success] = "Xoa Product that bai"
      end
    end
  end

  def update
    if request.xhr?
      @products = Product.find(params[:ids])
      @products.map {|p| p.update_attributes(category_id: params[:cate_id])}
      respond_to do |format|
        format.json{render json: {cate_id: params[:cate_id]}, status: "200"}
      end
    else
      if @product.update_attributes product_params
        flash[:success] = "Thay Doi Product Thanh Cong"
        redirect_to products_path
      else
        render :edit
      end
    end
  end

  private

  def load_product
    @product = Product.find_by params[:id]
    return if @product
    flash[:error] = "Khong tim thay product"
    redirect_to products_path
  end

  def product_params
    unless request.xhr?
      params.require(:product).permit :name, :price, :description, :status, :category_name,
        pictures_attributes: [:id, :name, :image_cache, :_destroy]
    end
  end
end
