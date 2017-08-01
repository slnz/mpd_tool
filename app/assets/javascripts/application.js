//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
$( document ).ready(function() {
  $('#donee_name_search').keyup(function(event){
    $.get('/find', { search: $(this).val()}, function(data) {
      var donees = $('#donees');
      donees.html('');
      $.each(data, function(index, donee) {
        donees.append(
          '<div class="donee"><a href="/' + donee['slug'] + '"><img src="' + donee['large_image'] + '"><span class="name">' + donee['name'] + '</span></a></div>'
        );
      });
      if(data.length === 0) {
        donees.append(
          '<div class="donee"><a><span class="name">No Search Results</span></a></div>'
        );
      }
    });
  });
});
