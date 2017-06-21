class ProductsController < ApplicationController
  before_action :load_product, only: [:edit, :update, :show, :destroy]

  def index
    @products = Product.all
    @categories = Category.all
  end

  def show; end

  def new
    @product = Product.new
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
    if @product.destroy
      flash[:success] = "Xoa Product Thanh Cong"
      redirect_to products_path
    else
      flash[:success] = "Xoa Product that bai"
    end
  end

  def update
    if @product.update_attributes product_params
      flash[:success] = "Thay Doi Product Thanh Cong"
      redirect_to products_path
    else
      render :edit
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
    params.require(:product).permit :name, :price, :description, :status, :category_name
  end
end
