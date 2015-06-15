
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