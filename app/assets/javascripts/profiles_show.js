function init_profiles_show() {

	$.datepicker.setDefaults({
      changeMonth: true,
      changeYear: true,
      yearRange: "-200:+0"
    });


	$('#add_phone_link').on('click', toggle_new_phone_form);
	$('#add_address_link').on('click', toggle_new_address_form);
	$('.best_in_place').best_in_place();
}

function toggle_new_phone_form() {
	$('#add_phone_link').toggle();
	$('form#new_phone').toggle();	
	$('#phone_number').focus();
	event.preventDefault();	
}

function toggle_new_address_form() {
	$('#add_address_link').toggle();
	$('form#new_address').toggle();	
	$('#address_line_one').focus();
	event.preventDefault();	
}