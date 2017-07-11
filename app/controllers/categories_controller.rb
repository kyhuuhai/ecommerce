class CategoriesController < ApplicationController
  before_action :find_category, only: [:update, :destroy]
  before_action :load_product_outside, only: :index
  def index
    @query_categories = Category.includes(:products).ransack params[:q]
    @categories = @query_categories.result
      .page(params[:page]).per 10
    @categories = Category.order(:name).search_by_name(params[:term]) if params[:term].present?
    @category = Category.new
    if params[:category_id] || (params[:product_name] && params[:product_ids])
      category_id = params[:category_id] || @products[0].category_id
      render json: {
        html_product: render_to_string(partial: "categories/cate_product",
          locals: {products: @products, id: category_id})
      }
    else
      respond_to do |format|
        format.html
        format.js
        format.json {render json: @categories.map(&:name)}
      end
    end
  end

  def create
    category = Category.new category_params
    if category.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to categories_path
  end

  def update
    if @category.update_attributes category_params
      respond_to_json t(".success"), 200, @category.name
    else
      respond_to_json @category.errors.full_messages.first, 422
    end
  end

  def destroy
    if @category.destroy
      respond_to_json t(".success"), 200
    else
      respond_to_json t(".fail"), 422
    end
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def find_category
    @category = Category.find_by id: params[:id]
    respond_to_html t(".not_found"), 400 unless @category
  end

  def respond_to_html message, status
    flash[:danger] = message
    redirect_to root_path
  end

  def respond_to_json message, status, name = nil
    respond_to do |format|
      format.json{render json: {flash: message, name: name}, status: status}
    end
  end

  def load_product_outside
    @products = if params[:category_id]
      @category = Category.find_by id: params[:category_id]
      if params[:delete]
        @category.products
      else
        Product.not_in(@category.products.map(&:id))
      end
    elsif params[:product_name] && params[:product_ids]
      Product.by_ids(params[:product_ids]).search_by_name(params[:product_name])
    else
      []
    end
  end
end
