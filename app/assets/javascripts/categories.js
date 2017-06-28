$(document).on('click', '.edit-edu-category', function(){
  var cate_id = this.dataset.id;
  var cate_name = $('#edu-category-name-' + cate_id).text();
  $('.name-edit-category').val(cate_name);
  $('.name-edit-category').data('id', cate_id);
  $('#editCategoryModal').modal('show');
});


$(document).on('click', '.edit-button', function(e){
  var cate_name = $('.name-edit-category').val();
  var cate_id = $('.name-edit-category').data('id');
  $.ajax({
    type: "PATCH",
    url: '/categories/' + cate_id,
    data: {category: {name: cate_name}},
    dataType: 'json',
    success: function(data) {
      if(data['status'] === 200) {
        $('#editCategoryModal').modal('hide');
        $('#edu-category-name-' + cate_id).html(
            data.name
          )
      }
    }
  });
});

$(document).on('click', '.delete-edu-category', function(){
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

$(document).on('keyup', '#q_name_cont', function() {
  console.log($('#q_name_cont').serialize())
  $.get($('#q_name_cont').attr('action'),
    $('#q_name_cont').serialize(), null, 'script');
});
