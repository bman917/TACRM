function init_profiles_index() {

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