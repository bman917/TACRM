function init_profiles_index() {
	$('#profile_birth_day').datepicker({
      changeMonth: true,
      changeYear: true,
      yearRange: "-200:+0"
    });

	$('#profile_first_name').focus();

	$('#show_new_profile_row_link').on('click', toggle_add_profile_div);
	$('#hide_new_profile_row_link').on('click', toggle_add_profile_div);

	$('.best_in_place').best_in_place();
}

function toggle_add_profile_div() {
	$('#profile_index').toggle();
	$('#show_new_profile_row_link').toggle();
	$('#add_profile').toggle();
	$('input[type=text]:first').focus();
	event.preventDefault();	
}