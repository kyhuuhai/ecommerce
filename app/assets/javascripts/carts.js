$(document).ready(function(){
  $('body').on('click', '.add-cart', function(e){
    e.preventDefault();
    var pro_id = $(this).data('p-id');
    $.ajax({
      type: 'POST',
      url: '/cart_details',
      data: {cart_detail: {product_id: pro_id}},
      success: function(data){
        if(data.status === "200"){
          $('#cart-group-button-' + pro_id).html('<a class="btn btn-danger remove-cart"'+
            ' data-p-id="'+ pro_id + '" data-cart-detail-id="'+ data["id"] +'" href="#">Remove from cart</a>');
          }
      }
    });
  });

  $('body').on('click', '.remove-cart', function(e){
    e.preventDefault();
    var pro_id = $(this).data('p-id');
    var id = $(this).data('cart-detail-id');
    $.ajax({
      type: 'DELETE',
      url: '/cart_details/' + pro_id,
      success: function(data){
        if(data.status === "200"){
          $('#cart-group-button-' + pro_id).html('<a class="btn btn-success add-cart"'+
            ' data-p-id="'+ pro_id + '" href="#">Add to cart</a>');
        }
      }
    });
  });
});
