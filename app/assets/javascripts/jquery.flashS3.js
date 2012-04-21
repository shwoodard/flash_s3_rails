//= require vendor/flash_s3/swfupload

(function ($) {
  var methods = {
    initialize: function (options) {
      var elem = $(this);

      methods.elem = function () {
        return $(elem);
      };

      var settings = $.extend(true, {
        file_queued_handler: methods.handleFileQueued,

        upload_success_handler: methods.handleFileSuccess,

        upload_progress_handler: methods.handleFileProgress,

        file_size_limit : "0"
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

    sfsu: function () {
      return methods.elem().data('flashS3Swfu');
    },

    handleFileSuccess: function (file, serverData) {
      var pb = methods.progressbar.call(methods.elem(), file.id);
      if ($(pb).is('.ui-progressbar')) {
        pb.progressbar('value', 100);
      } // TODO else: make a css progress bar and handle here

      var settings = methods.elem().data('flashS3Settings');
      var recordKlass = settings.custom_settings.record_class_name;
      var attachmentName = settings.custom_settings.attachment_name;
      var s3KeyQueryParamKey = recordKlass + '[' + attachmentName + '][s3_key]';
      var params = {};
      params[s3KeyQueryParamKey] = $($.parseXML(serverData)).find('Key').text();
      params.s3_file_class_name = recordKlass;
      $.post(settings.custom_settings.create_s3_attachment_url, params);
      this.startUpload();
    },

    handleFileProgress: function (file, bytesLoaded, bytesTotal) {
      var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
      var pb = methods.progressbar.call(methods.elem(), file.id);
      if ($(pb).is('.ui-progressbar')) {
        pb.progressbar('value', percent);
      } // TODO else: make a css progress bar and handle here
    },

    handleFileQueued: function (file) {
      var settings = methods.elem().data('flashS3Settings');

      var listItem;
      if (settings.custom_settings.file_upload_list_item_renderer) {
        listItem = $.globalEval(settings.custom_settings.file_upload_list_item_renderer).call(this, file);
      } else {
        listItem = methods.fileUplaodListItemRenderer.call(this, file);

        $('.ui-icon-close', listItem).click(function (evt) {
          evt.preventDefault();
          methods.sfsu().cancelUpload(file.id);
          listItem.remove();
        });
      }
      methods.elem().find('ol.flash_s3-file_transfers').append(listItem);
    },

    fileUplaodListItemRenderer: function (file) {
      var listItem = $('<li class="flash_s3-file" id="' + file.id + '">' +
          '<div class="flash_s3-filename">' + file.name + '</div>' +
          '<div class="flash_s3-progress_bar" />' +
          '<div class="ui-icon-close ui-icon" />' +
          '</li>');
      var pb;
      if (methods.enablesJQueryUI()) {
        pb = listItem.find('.flash_s3-progress_bar').progressbar();
        listItem.data("flashS3Progressbar", pb);
      } else {
        pb = listItem.find('.flash_s3-progress_bar');
        listItem.data("flashS3Progressbar", pb);
      }

      return listItem;
    },
    enablesJQueryUI: function () {
      return true;
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
