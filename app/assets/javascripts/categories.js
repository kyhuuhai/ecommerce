$(document).ready(function(){
  $('body').on('click', '.edit-edu-category', function(){
    var cate_id = this.dataset.id;
    var cate_name = $('#edu-category-name-' + cate_id).text();
    $('.name-edit-category').val(cate_name);
    $('.name-edit-category').data('id', cate_id);
    $('#editCategoryModal').modal('show');
  });


  $('body').on('click', '.edit-button', function(e){
    var cate_name = $('.name-edit-category').val();
    var cate_id = $('.name-edit-category').data('id');
    $.ajax({
      type: "PATCH",
      url: '/categories/' + cate_id,
      data: {category: {name: cate_name}},
      dataType: 'json',
      success: function(data) {
        $('#editCategoryModal').modal('hide');
        $('#edu-category-name-' + cate_id).html(
            data.name
          )
      },
      error: function(e, data, status, xhr){
        message = JSON.parse(e.responseText)
        alert(message.flash)
          console.log(message.flash)
      }
    });
  });

  $('body').on('click', '.delete-edu-category', function(){
    var cate_id = this.dataset.id;
    $.ajax({
      type: "DELETE",
      url: '/categories/' + cate_id,
      success: function(data) {
        if(data['status'] === 200) {
          $('#edu-category-' + cate_id).remove();
        }
      }
    });
  });

  $('body').on('click', '#add_product', function(){
    var cate_id = this.dataset.id;
    $.ajax({
      type: "GET",
      url: '/categories',
      data: {category_id: cate_id},
      dataType: 'json',
      success: function(data) {
        $('#cate_product_'+ cate_id).html(data['html_product']);
      }
    });
  });

  $('body').on('click', '#remove_product', function(){
    var cate_id = this.dataset.id;
    $.ajax({
      type: "GET",
      url: '/categories',
      data: {category_id: cate_id, delete: true},
      dataType: 'json',
      success: function(data) {
        $('#cate_product_'+ cate_id).html(data['html_product']);
      }
    });
  });

  $('body').on('click', '#add_product', function(){
    var id = this.dataset.id;
    var html = '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>' +
    '<button type="submit" class="btn btn-primary submit-add-product" data-id="' + id + '">Add</button>';
    $('.modal-footer').html(html);
  });

  $('body').on('click', '#remove_product', function(){
    var id = this.dataset.id;
    var html = '<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>' +
      '<button type="submit" class="btn btn-danger submit-remove-product" data-id="' + id + '">Remove</button>';
    $('.modal-footer').html(html);
  });

  $('body').on('click', '.submit-add-product', function(){
    var cate_id = this.dataset.id;
    var arr_checked = [];
    $(".cate-product input:checkbox:checked").each(function(){
      arr_checked.push($(this).val());
    });
    $.ajax({
      type: "PATCH",
      url: '/products/1',
      data: {ids: arr_checked, cate_id: cate_id},
      dataType: 'json',
      success: function(data) {
        $('#productModal' + data['cate_id']).modal('hide');
      }
    });
  });

  $('body').on('click', '.submit-remove-product', function(){
    var cate_id = this.dataset.id;
    var arr_checked = [];
    $(".cate-product input:checkbox:checked").each(function(){
      arr_checked.push($(this).val());
    });
    $.ajax({
      type: "DELETE",
      url: '/products/1',
      data: {ids: arr_checked, cate_id: cate_id},
      dataType: 'json',
      success: function(data) {
        $('#productModal' + data['cate_id']).modal('hide');
      }
    });
  });

  $('body').on('click', '#check_all', function(){
    if ($('#check_all')[0].checked){
      $('.product-checkbox').prop('checked', true);
    } else {
      $('.product-checkbox').prop('checked', false);
    }
  });

  $('body').on('keyup', '#q_name_cont', function() {
    console.log($('#q_name_cont').serialize())
    $.get($('#q_name_cont').attr('action'),
      $('#q_name_cont').serialize(), null, 'script');
  });

  $('body').on('focus', '#product_category_name', function(e){
     $('#product_category_name').autocomplete({
      source: $('#product_category_name').data('autocomplete-source'),
      minLength: 0,
    }).focus(function(){
      $(this).autocomplete("search")
    });
  });
});
