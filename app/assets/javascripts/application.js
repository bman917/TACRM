// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require best_in_place
//= require best_in_place.purr
//= require turbolinks
//= require_tree .

function application_init() {
	$.datepicker.setDefaults({ dateFormat: 'MM dd, yy' });

	$('a.slow_link').on('click', show_waiting);
}

function show_waiting() {
	$('#content').append("<div class='overlay'></div>");
	$('#wait_message').toggle();
	$('#wait_message').addClass('modal');
}

// For this to work, the form and the 'show link' must enclosed in a .toggler class.
// For example:
// <div class="toggler">
// 	<%=link_to 'Add Note', '', id: "add_note_link", class: 'add_fields no-print'%>
// 	<%=render 'notes/form'%>
// </div>
function toggle_form(event) {
	var form = $(this).closest('.toggler').find('form');
	form.toggle();
	form.find('.focus_on_toggle').focus();
	
	$(this).closest('.toggler').find('.add_fields').toggle();
	event.preventDefault();	
}