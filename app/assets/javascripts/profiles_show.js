function init_profiles_show() {

	$.datepicker.setDefaults({
      changeMonth: true,
      changeYear: true,
      yearRange: "-200:+0"
    });

	$('.toggler a').on('click', toggle_form);
	$('.best_in_place').best_in_place();
	$('.section_hide_link').on('click', toggle_section);
}

function toggle_section() {
	$(this).closest('.profile_show_section').find('.section_body').slideToggle("fast");

	if( $(this).text() == '+') {
		$(this).text('-');
	} else {
		$(this).text('+');
	}
	
	event.preventDefault();
}