function init_profiles_index() {

	$('a.slow_link').on('click',  overlay);

	// Select filter for different profile types.
	// Causes profile filtered by profile type to be loaded.
	// Calls overlays while profiles are being retreived
	$('#profile_type').change(function() {
		$('#add_profile').fadeOut('fast');
		overlay();
		$('#type_filter').submit();
	});

	/*	
	This is the link that retreives the Add Profile form.
	When the button is clicked the #prepare_form div that shows
	a waiting message is made visible. When the waiting message 
	is visible subsequent clicks to .add_client_link buttons should
	be disabled.
	*/
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