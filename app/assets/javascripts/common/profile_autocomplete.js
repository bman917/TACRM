var pa_change_link_css = '.profile_autocomplete_container a.change_link';
var pa_profile_id_css = '.profile_autocomplete_container .profile_id';
var pa_full_name_css = '.profile_autocomplete_container #profile_full_name';

function profile_autocomplete_setup(preloaded_profiles) {
   /*Setup autocomplete field for profile names*/
  $(pa_full_name_css).autocomplete({
      source: preloaded_profiles,
      minLength: 2,
      select: profile_selected
    });
    profile_autocomplete_setup_form_logic()
}

function profile_autocomplete_setup_form_logic() {
    /*For the change link. Reset profile autocomplet field. */
  $(pa_change_link_css).on('click', function(event) {
    event.preventDefault();
    reset_profile_autocomplete();
    $(this).hide();
  });

  /*When the profile autocomplete field losses focus, 
    checks must be done to ensure that a profile has been selected.*/
  $('#profile_full_name').focusout(function() {
    is_ok = ($(pa_profile_id_css).val() != false);
    if (is_ok)
    {
      disable_profile_autocomplete();
    }
    else
    {
      $('.profile_autocomplete_container').addClass('alert');
      $('form input[type=submit]').prop("disabled",true);
    }
  });

}

/* 
Call back method for autocomplete. 
Sets the profile id of the profile selected from the autocomplete dropdown
*/
function profile_selected(event, ui)
{
  $(pa_profile_id_css).val(ui.item.id);
  tab = next_tab_index();
  $("[tabindex='" + tab + "']").focus();
  disable_profile_autocomplete();
}


function disable_profile_autocomplete() {
  currenttab = $('#profile_full_name').attr("tabindex");
    $('#profile_full_name').prop("disabled",true);
    $(pa_change_link_css).show();
    $('.profile_autocomplete_container').removeClass('alert');
    $('form input[type=submit]').removeAttr("disabled");
}

/* Reset the input field(s) for client/profile */
function reset_profile_autocomplete() {
  $(pa_profile_id_css).val('');
  $(pa_full_name_css).val('');
  $(pa_full_name_css).removeAttr('disabled');
  $(pa_full_name_css).focus();
  $(pa_change_link_css).hide();
}

