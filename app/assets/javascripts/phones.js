function init_phone_form_container() {
  /*Add validation listener*/
  $('form#new_phone_form').submit(phone_form_submit_validation);
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