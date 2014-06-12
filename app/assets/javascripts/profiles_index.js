function init_profiles_index() {

  $('a.slow_link').on('click',  overlay);

  $('a.spin_on_click').on('click', spin_and_overlay);

  // Select filter for different profile types.
  // Causes profile filtered by profile type to be loaded.
  // Calls overlays while profiles are being retreived
  $('#profile_type').change(function() {
    $('#add_profile').fadeOut('fast');
    overlay();
    $('#type_filter').submit();
  });




  profile_index_init_data_table();

}

/* currently used for locking and ulocking profiles. but i think this might be reusable.*/
function spin_and_overlay() {

  //this only works when the link has a data-confirm attribute.
  //what this says is wait for the user to confirm/cancel before doing anything.
  $(this).on('confirm:complete', function(e,answer) {
    if (answer) {
      $(this).parent().spin('small');
      overlay();
    }else {
      $(this).parent().stop_spinner();
      remove_overlay();
    }
  });
}

function profile_index_init_data_table() {
  $('table#profile_index').dataTable( {
        bJQueryUI: true,
        iDisplayLength: 10,
        "sPaginationType": "full_numbers",
    } );

    $('#profile_index_filter input').focus();
}