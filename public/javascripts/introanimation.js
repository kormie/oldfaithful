jQuery.fn.loopIntro = function(){
  var $div = $(this)
  var $image = $div.find('img:last-child');
  
  $image.fadeOut(8000, function(){
    $image.prependTo($div).show();
    $div.loopIntro();
  });
  
  

}
$(document).ready(function() {
  $('div#intro').loopIntro();

});
