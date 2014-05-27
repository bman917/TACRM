function init_phone_form_container() {
  remove_overlay();

  //Action when close link is clicked
  $('#phone_form_container a.close').on('click', function(e){
    e.preventDefault();
    phone_form_close();
  });

  /*Add validation listener*/
  $('form#new_phone_form').submit(phone_form_submit_validation);
}

function phone_form_close() {
    $('#phone_form_container').slideUp('fast', function(){$(this).remove();});
    $('.overlay-5').fadeOut('fast', function(){$(this).remove();}); 
}

function phone_form_submit_validation() {

  isFormValid = true;
  
  $($("input.required").get().reverse()).each(function(){
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