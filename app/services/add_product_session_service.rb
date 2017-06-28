class AddProductSessionService
  def initialize(params)
    @product_id = params[:product_id]
    @cart_details = params[:cart_details]
  end

  def add_product
    @cart_details << @product_id
  end

  def remove_product
    @cart_details.delete @product_id
    @cart_details
  end
end