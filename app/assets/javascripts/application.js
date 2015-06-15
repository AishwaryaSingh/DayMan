// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.js
//= require moment
//= require fullcalendar
//= require bootstrap

//= require new_form.js
//= require professor_show_table.js
//= require show_calendar_user.js
//= require log_in.js


$(document).ready(function() 
{
  $(function()
  {
  	setTimeout(function()
  	{
    	$('.alert').slideUp(500);
  	}, 1000);
	});

	$(function()
  {
    setTimeout(function()
  	{
      $('.up').slideToggle(3500);
    	$('.greet_user').slideToggle(2000);
  	}, 500);
	});
});