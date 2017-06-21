$(function() {
    $('#login-form-link').click(function(e) {
    $("#login-form").delay(100).fadeIn(100);
    $("#register-form").fadeOut(100);
    $('#register-form-link').removeClass('active');
    $(this).addClass('active');
    e.preventDefault();
  });
  $('#register-form-link').click(function(e) {
    $("#register-form").delay(100).fadeIn(100);
    $("#login-form").fadeOut(100);
    $('#login-form-link').removeClass('active');
    $(this).addClass('active');
    e.preventDefault();
  });

});
var app = window.app = {};

app.Books = function() {
  this._input = $('#books-search-txt');
  this._initAutocomplete();
};

app.Books.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: '/products',
        appendTo: '#books-search-results',
        select: $.proxy(this._select, this)
      })
      .autocomplete('instance')._renderItem = $.proxy(this._render, this);
  },

  _render: function(ul, item) {
    var markup = [
      '<a href="/products/' + item.id +'" >',
      '<span class="img">',
        '<img src="' + item.image_url + '" />',
      '</span>',
      '<span class="title">' + item.name + '</span>',
      '<span class="author">' + item.description + '</span>',
      '<span class="price">' + item.price +'</span>',
      '</a>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  },

  _select: function(e, ui) {
    this._input.val(ui.item.name + ' - ' + ui.item.description);
    return false;
  }
};
