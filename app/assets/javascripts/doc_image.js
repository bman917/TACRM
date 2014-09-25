function init_doc_image_uploader() {
  $('#identification_doc_image').fileupload({
    dataType: 'script',
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $('#progress .bar').css('width', progress + '%');
      if (progress == 100)
      {
        $('#finishing').show();
      }
    },
    add: function (e, data) {
      types = /(\.|\/)(gif|jpe?g|png|bmp)$/i;
      file = data.files[0];
      if (types.test(file.type) || types.test(file.name))
      {
        console.log('Added file: ' + data.files[0].name + ", URL: " + data.url);
        $('#identification_doc_image').hide();
        $('#file_list').show().append("<p>" + data.files[0].name + "</p>");
        $('#progress').show().css('height','20px');
        data.submit();
      }
      else
      {
        alert("'" + file.name + "'  is not an image file. \n\n Only image files are allowed for upload");
      }
    },
    done: function (e, data) {
      if (data.result.indexOf('error_explanation') < 0)
      {
        $('#modal_form_container').remove();
        $('.overlay-5').remove();
      }
    }
  });
}