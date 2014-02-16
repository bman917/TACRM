function init_profiles_index() {

	$('#profile_first_name').focus();





	$('#hide_new_profile_row_link').on('click', toggle_add_profile_div);

	$('.best_in_place').best_in_place();

	$('#new_profile').on('submit', function() {
		$('#new_profile_save_button').attr("disabled","disabled");
		$('#new_profile_save_button').val("Saving...");
		$('#content').append("<div class='overlay'></div>");
		$('#wait_message').toggle();
		$('#wait_message').addClass('modal');
	});

	$('a.slow_link').on('click',  overlay);

	$('#profile_type').change(function() {
		$('#add_profile').fadeOut('fast');
		overlay();
		$('#type_filter').submit();
	});

	$('.add_client_link').on('click', function(e) {

		if ($('#prepare_form').is(":visible")) {
			e.preventDefault();
			return false;
		} else {
			$('.add_profile').fadeOut('fast', function() { $(this).remove();});
			$('#prepare_form').fadeIn('fast');
		}
	});
}

function overlay() {
		$('#content').append("<div class='overlay'></div>");
		$('#wait_message').toggle();
		$('#wait_message').addClass('modal');	
}

function remove_overlay() {
	$('.overlay').remove();
	$('#wait_message').removeClass('modal');
	$('#wait_message').toggle();
}



function toggle_add_profile_div(event) {
	$('#profile_index').toggle();
	// $('#show_new_profile_row_link').toggle();
	$('#add_profile').slideToggle('fast');
	$('input[type=text]:first').focus();
	event.preventDefault();	
}

