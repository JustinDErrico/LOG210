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
//= require bootstrap
//= require_tree .
$( document ).ready(function() {
  if ($('#flash_notice').text() == "Invalid credentials" || $('#flash_notice').text() == "Password Mismatch.")
      $('#flash_notice').css({ "color": "red"})
  else
      $('#flash_notice').css({ "color": "green"})

  $('#commande_restaurant_id').change(function(){
		get_menu();
	});
});
function remove_fields(link)
{
    $(link).parent().find('input[type=hidden]').val(1);
    $(link).parent().parent().hide();
}

function add_fields(link, association, content)
{
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");

    $(link).before(content.replace(regexp, new_id));
}

function get_menu()
{
    $.ajax({
     	url: "/get_menus",
	    type: "GET",
	    data: 
	    {
	    	id: $('#commande_restaurant_id option:selected').val() 
	    },
  	 	complete: function(response, status) 
      {
        $('#commande').html(response.responseText);

        if(response.responseText.trim())
        {
          $('input[type=submit]').show();
        }
        else
        {
          $('input[type=submit]').hide();
        }
      }
    });
}