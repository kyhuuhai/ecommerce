class CategoriesController < ApplicationController
  before_action :load_category, only: [:edit, :update, :show, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = "tao category thanh cong !!"
      redirect_to categories_path
    else
      render :new
    end
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def destroy
    if @category.destroy
      flash[:success] = "xoa thanh cong"
     else
       flash[:success] = "xoa khong thanh cong"
    end
      redirect_to categories_path
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = "cap nhat thanh cong"
      redirect_to categories_path
      else
        render :edit
    end
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:error] = "khong tim thay product. sorry"
    redirect_to categories_path
  end

  def category_params
    params.require(:category).permit :name
  end
end
