function init_profile_form_container() {
  //Action when close link is clicked
  $('#profile_form_container a.close').on('click', function(e){
    e.preventDefault();
    profile_form_close();
  });

  /*Add validation listener*/
  $('form#new_profile_form').submit(profile_form_submit_validation);
}

function profile_form_close() {
    $('#profile_form_container').slideUp('fast', function(){$(this).remove();});
    $('.overlay-5').fadeOut('fast', function(){$(this).remove();}); 
}

function profile_form_submit_validation() {
  isFormValid = true;
  
  $($(".required").get().reverse()).each(function(){
      if ($.trim($(this).val()).length == 0){
          $(this).effect('shake');
          $(this).focus();
          isFormValid = false;
      }
  });

  if(isFormValid == false) {
    event.preventDefault();
    event.stopPropagation();
  }
}