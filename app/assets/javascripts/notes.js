function init_note_form_container() {
  /*Add validation listener*/
  $('form#new_note_form').submit(note_form_submit_validation);
}

function note_form_submit_validation() {

  isFormValid = true;
  
  $($("textarea.required").get().reverse()).each(function(){
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