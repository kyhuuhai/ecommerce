class ProductsController < ActionController::Base
	def index
 	 	@products = Product.all
 	 	@categories = Category.all
  	end
end
