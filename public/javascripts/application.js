// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(function() {
	$('#not_current_wrap').hide();
  $('#expand_arrow').click(function(e) {
    e.preventDefault();
    $('#not_current_wrap').slideToggle('slow', function() {
      // Animation complete.
    });
  });
});