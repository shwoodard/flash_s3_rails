//= require vendor/flash_s3/swfupload

(function ($) {
  var methods = {
    initialize: function (options) {
      var elem = $(this);

      methods.elem = function () {
        return $(elem);
      };

      var settings = $.extend({
        debug: true,

        file_dialog_complete_handler: function () {
          // this.startUpload();
        },

        file_queued_handler: function (file) {
          methods.elem().find('a.flash_s3-start_button').css('display', 'block');
          var listItem = $('<li class="flash_s3-file" id="' + file.id + '"><div class="flash_s3-filename">' + file.name + '</div><div class="flash_s3-progress_bar" ></li>');
          var progressbar = listItem.appendTo(elem.find('ol.flash_s3-file_transfers')).find('.flash_s3-progress_bar').progressbar();
          listItem.data("flashS3Progressbar", progressbar);
        },

        upload_success_handler: methods.handleFileSuccess,

        upload_progress_handler: methods.handleFileProgress
      }, options);

      elem.data('flashS3Settings', settings);

      var sfwu = new SWFUpload(settings);
      elem.data('flashS3Swfu', sfwu);

      elem.find('a.flash_s3-start_button').click(function (evt) {
        evt.preventDefault();
        sfwu.startUpload();
      });
    },

    progressbar: function (fileId) {
      return $('li#' + fileId).data('flashS3Progressbar');
    },

    handleFileSuccess: function (file, serverData) {
      methods.progressbar.call(methods.elem(), file.id).progressbar('value', 100);
      this.startUpload();
    },

    handleFileProgress: function (file, bytesLoaded, bytesTotal) {
      var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
      methods.progressbar.call(methods.elem(), file.id).progressbar('value', percent);
    }
  };

  $.makePlugin = function (name, methods) {
    $.fn[name] = function () {
      var retVal;
      var command = arguments[0] || 'initialize';
      var args, options;
      if ($.isPlainObject(command) || command === 'initialize') {
        command = 'initialize';
        args = [arguments[0] || {}];
      } else if (command) {
        args = $.makeArray(arguments).slice(1);
      }

      var iterator = $(this).each(function () {
        var elem = $(this);
        retVal = methods[command].apply(elem, args);
      });

      return retVal || iterator;
    };
  };

  $.makePlugin('flashS3', methods);
})(jQuery);
