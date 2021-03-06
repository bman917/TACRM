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
//= require dataTables/jquery.dataTables
//= require best_in_place
//= require best_in_place.purr
//= require turbolinks
//= require jquery.liquid-slider.min
//= require jquery.liquid-slider-ajax
//= require jquery.touchSwipe.min
//= require hide_toggler
//= require common_tools
//= require common_tools/jquery-spin
//= require common_tools/best_in_place_default_binds
//= require jquery-fileupload/basic
//= require_tree .

function application_init() {
	$.datepicker.setDefaults({ 
		dateFormat: 'MM dd, yy', 
		changeMonth: true,
		changeYear: true,
		yearRange: "c-100:c+50"});

	$('a.slow_link').on('click', overlay);

	liquid_slider_auto_height();
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
	adjustHeight();
	
}