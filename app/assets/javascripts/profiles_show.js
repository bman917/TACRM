function init_profiles_show() {
	$('#add_phone_link').on('click', toggle_new_phone_form)

}

function toggle_new_phone_form() {
	$('#add_phone_link').toggle();
	$('form#new_phone').toggle();	
	$('#phone_number').focus();
	event.preventDefault();	
}