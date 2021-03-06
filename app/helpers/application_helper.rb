module ApplicationHelper

  def cart_button cart, product_id
    if @cart_detail_session.include? product_id.to_s
      link_to "Remove from cart", "#", class: "btn btn-danger remove-cart",
        data: {p_id: product_id}
    else
      link_to "Add to cart", "#", class: "btn btn-success add-cart",
        data: {p_id: product_id}
    end
  end
end
