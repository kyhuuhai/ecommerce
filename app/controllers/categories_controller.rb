class CategoriesController < ApplicationController

  def index
    @categories = Category.order(:name).search(params[:term])
    render json: @categories.map(&:name)
  end
end