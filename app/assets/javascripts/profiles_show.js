function init_profiles_show() {

	$('.toggler a').on('click', toggle_form);
	$('.best_in_place').best_in_place();
}

function toggle_section(event) {
	$(this).closest('.profile_show_section').find('.section_body').slideToggle("fast");

	if( $(this).text() == '+') {
		$(this).text('-');
	} else {
		$(this).text('+');
	}
	
	event.preventDefault();
}