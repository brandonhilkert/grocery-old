//= require_tree ./lib

$(function() {
  $('ul.items li').click(function(){
    $(this).toggleClass('cross-off');
  });
});