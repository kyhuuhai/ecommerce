class CategoriesController < ApplicationController
  before_action :find_category, only: [:update, :destroy]

  def index
    @query_categories = Category.ransack params[:q]
    @categories = @query_categories.result
      .page(params[:page]).per 10
    # @categories = Category.order(:name).search(params[:term])
    @category = Category.new
    respond_to do |format|
      format.html
      format.js
      format.json{@categories.map(&:name)}
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
      respond_to_json t(".fail"), 400
    end
  end

  def destroy
    if @category.destroy
      respond_to_json t(".success"), 200
    else
      respond_to_json t(".fail"), 400
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
      format.json{render json: {flash: message, status: status, name: name}}
    end
  end
end
