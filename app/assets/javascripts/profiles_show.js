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
	$('.best_in_place').best_in_place();
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