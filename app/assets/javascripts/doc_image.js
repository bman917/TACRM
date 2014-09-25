function init_doc_image_uploader() {
  $('#identification_doc_image').fileupload({
  dataType: 'script',
  progressall: function (e, data) {
    var progress = parseInt(data.loaded / data.total * 100, 10);
    $('#progress .bar').css(
        'width',
        progress + '%'
    )
  },
  add: function (e, data) {
    console.log('Added file: ' + data.files[0].name + ", URL: " + data.url);
    $('#identification_doc_image').hide();
    $('#file_list').show().append("<p>" + data.files[0].name + "</p>");
    $('#progress').show().css('height','20px');
    data.submit();
  },
  done: function (e, data) {
    if (data.result.indexOf('error_explanation') < 0)
    {
      remove_overlay();
      $('#modal_form_container').remove();
      $('.overlay-5').remove();
    }
  }
});
}