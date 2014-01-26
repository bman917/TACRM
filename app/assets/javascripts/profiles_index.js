function init_profiles_index() {
	$('#profile_birth_day').datepicker({
      changeMonth: true,
      changeYear: true,
      yearRange: "-200:+0"
    });

	$('#profile_first_name').focus();

	$('#show_new_profile_row_link').on('click', toggle_new_profile_row);
	$('#hide_new_profile_row_link').on('click', toggle_new_profile_row);
}

function toggle_new_profile_row() {
	$('#show_new_profile_row_link').toggle();
	$('#new_profile_row').toggle();
	$('#profile_first_name').focus();
	event.preventDefault();	
}