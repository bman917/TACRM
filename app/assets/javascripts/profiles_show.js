function init_profiles_show() {

	$.datepicker.setDefaults({
      changeMonth: true,
      changeYear: true,
      yearRange: "-200:+0"
    });


	$('#add_phone_link').on('click', toggle_new_phone_form);
	$('#add_address_link').on('click', toggle_new_address_form);
	$('.member_link_group').on('click', toggle_new_member_form);
	$('#add_group_link').on('click', toggle_new_group_form);
	$('#create_account_link').on('click', toggle_create_account_form);
	$('#hide_note_form_link').on('click', toggle_new_note_form);
	$('#add_note_link').on('click', toggle_new_note_form);


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

function toggle_new_note_form() {
	$('#add_note_link').toggle();
	$('form#new_note').toggle();
	$('#note_note').focus();
	event.preventDefault();	
}

function toggle_create_account_form() {
	$('#create_account').toggle();
	$('#create_account_link').toggle();
	$('#new_account #account_name').focus();
	event.preventDefault();	
}

function toggle_new_group_form() {
	$('#add_group_link').toggle();
	$('form#new_group').toggle();
	$('#group_name').focus();
	event.preventDefault();	
}

function toggle_new_member_form() {
	id = $(this).attr("id");
	group_id = parseInt(id.match(/\d+/),10);

	$("#group_" + group_id).find("form").toggle();
	$("#group_" + group_id).find(".member_link_group").toggle();

	event.preventDefault();	
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