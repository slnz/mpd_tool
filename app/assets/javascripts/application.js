//= require jquery
//= require jquery_ujs
//= require jquery-ui/autocomplete
//= require autocomplete-rails
//= require bootstrap-sprockets
//= require_tree .
$( document ).ready(function() {
  $('#donee_name_search').bind('railsAutocomplete.select', function(event, data){
    window.location.href = '/' + data.item.slug;
  });
});
