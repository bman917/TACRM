function init_profiles_index() {
	// $('#profile_birth_day').datepicker({
 //      changeMonth: true,
 //      changeYear: true,
 //      yearRange: "-200:+0"
 //    });

	$('#profile_first_name').focus();

	$('#show_new_profile_row_link').on('click', toggle_add_profile_div);
	$('#hide_new_profile_row_link').on('click', toggle_add_profile_div);

	$('.best_in_place').best_in_place();

	$('#new_profile').on('submit', function() {
		$('#new_profile_save_button').attr("disabled","disabled");
		$('#new_profile_save_button').val("Saving...");
		$('#content').append("<div class='overlay'></div>");
		$('#wait_message').toggle();
		$('#wait_message').addClass('modal');
	});

	$('a.slow_link').on('click',  function() {
		$('#content').append("<div class='overlay'></div>");
		$('#wait_message').toggle();
		$('#wait_message').addClass('modal');
	});


}

function toggle_add_profile_div(event) {
	$('#profile_index').toggle();
	$('#show_new_profile_row_link').toggle();
	$('#add_profile').toggle();
	$('input[type=text]:first').focus();
	event.preventDefault();	
}

