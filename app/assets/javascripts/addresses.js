function init_address_form_container() {
  $('div.country_not_found select').removeClass('optional');
  $('div.country_not_found select').addClass('required');


  /*Add validation listener*/
  $('form#new_address_form').submit(address_form_submit_validation);

}

function address_form_submit_validation(event) {

  isFormValid = true;
  
  $($("select.required").get().reverse()).each(function(){
      if ($.trim($(this).val()).length == 0){
          $(this).effect('shake');
          $(this).focus();
          isFormValid = false;
      }
  });

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