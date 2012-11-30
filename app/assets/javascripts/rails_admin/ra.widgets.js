(function() {

  $(document).live('rails_admin.dom_ready', function() {
    var array, goBootstrapWysihtml5s, goCkeditors, goCodeMirrors, options,
      _this = this;
    if ($('form').length) {
      $('form [data-color]').each(function() {
        var that;
        that = this;
        return $(this).ColorPicker({
          color: $(that).val(),
          onShow: function(el) {
            $(el).fadeIn(500);
            return false;
          },
          onHide: function(el) {
            $(el).fadeOut(500);
            return false;
          },
          onChange: function(hsb, hex, rgb) {
            $(that).val(hex);
            return $(that).css('backgroundColor', '#' + hex);
          }
        });
      });
      $('form [data-datetimepicker]').each(function() {
        return $(this).datetimepicker($(this).data('options'));
      });
      $('form [data-enumeration]').each(function() {
        if ($(this).is('[multiple]')) {
          return $(this).filteringMultiselect($(this).data('options'));
        } else {
          return $(this).filteringSelect($(this).data('options'));
        }
      });
      $('form [data-fileupload]').each(function() {
        var input;
        input = this;
        return $(this).find(".delete input[type='checkbox']").live('click', function() {
          return $(input).children('.toggle').toggle('slow');
        });
      });
      $('form [data-fileupload]').change(function() {
        var ext, image_container, input, reader;
        input = this;
        image_container = $("#" + input.id).parent().children(".preview");
        if (!image_container.length) {
          image_container = $("#" + input.id).parent().prepend($('<img />').addClass('preview')).find('img.preview');
          image_container.parent().find('img:not(.preview)').hide();
        }
        ext = $("#" + input.id).val().split('.').pop().toLowerCase();
        if (input.files && input.files[0] && $.inArray(ext, ['gif', 'png', 'jpg', 'jpeg', 'bmp']) !== -1) {
          reader = new FileReader();
          reader.onload = function(e) {
            return image_container.attr("src", e.target.result);
          };
          reader.readAsDataURL(input.files[0]);
          return image_container.show();
        } else {
          return image_container.hide();
        }
      });
      $('form [data-filteringmultiselect]').each(function() {
        $(this).filteringMultiselect($(this).data('options'));
        if ($(this).parents("#modal").length) {
          return $(this).parents('.control-group').find('.btn').remove();
        } else {
          return $(this).parents('.control-group').first().remoteForm();
        }
      });
      $('form [data-filteringselect]').each(function() {
        $(this).filteringSelect($(this).data('options'));
        if ($(this).parents("#modal").length) {
          return $(this).parents('.control-group').find('.btn').remove();
        } else {
          return $(this).parents('.control-group').first().remoteForm();
        }
      });
      $('form [data-nestedmany]').each(function() {
        var content, field, nav, toggler;
        field = $(this).parents('.control-group').first();
        nav = field.find('> .controls > .nav');
        content = field.find('> .tab-content');
        toggler = field.find('> .controls > .btn-group > .toggler');
        content.children('.fields:not(.tab-pane)').addClass('tab-pane').each(function() {
          $(this).attr('id', 'unique-id-' + (new Date().getTime()) + Math.floor(Math.random() * 100000));
          return nav.append('<li><a data-toggle="tab" href="#' + this.id + '">' + $(this).children('.object-infos').data('object-label') + '</a></li>');
        });
        if (nav.find("> li.active").length === 0) {
          nav.find("> li > a[data-toggle='tab']:first").tab('show');
        }
        if (nav.children().length === 0) {
          nav.hide();
          content.hide();
          return toggler.addClass('disabled').removeClass('active').children('i').addClass('icon-chevron-right');
        } else {
          if (toggler.hasClass('active')) {
            nav.show();
            content.show();
            return toggler.children('i').addClass('icon-chevron-down');
          } else {
            nav.hide();
            content.hide();
            return toggler.children('i').addClass('icon-chevron-right');
          }
        }
      });
      $('form [data-nestedone]').each(function() {
        var content, field, first_tab, nav, toggler;
        field = $(this).parents('.control-group').first();
        nav = field.find("> .controls > .nav");
        content = field.find("> .tab-content");
        toggler = field.find('> .controls > .toggler');
        content.children(".fields:not(.tab-pane)").addClass('tab-pane active').each(function() {
          return nav.append('<li><a data-toggle="tab" href="#' + this.id + '">' + $(this).children('.object-infos').data('object-label') + '</a></li>');
        });
        first_tab = nav.find("> li > a[data-toggle='tab']:first");
        first_tab.tab('show');
        field.find("> .controls > [data-target]:first").html('<i class="icon-white"></i> ' + first_tab.html());
        if (toggler.hasClass('active')) {
          toggler.children('i').addClass('icon-chevron-down');
          return content.show();
        } else {
          toggler.children('i').addClass('icon-chevron-right');
          return content.hide();
        }
      });
      $('form [data-polymorphic]').each(function() {
        var field, object_select, type_select, urls;
        type_select = $(this);
        field = type_select.parents('.control-group').first();
        object_select = field.find('select').last();
        urls = type_select.data('urls');
        return type_select.on('change', function(e) {
          if ($(this).val() === '') {
            return object_select.html('<option value=""></option>');
          } else {
            return $.ajax({
              url: urls[type_select.val()],
              data: {
                compact: true,
                all: true
              },
              beforeSend: function(xhr) {
                return xhr.setRequestHeader("Accept", "application/json");
              },
              success: function(data, status, xhr) {
                var html;
                html = '<option></option>';
                $(data).each(function(i, el) {
                  return html += '<option value="' + el.id + '">' + el.label + '</option>';
                });
                return object_select.html(html);
              }
            });
          }
        });
      });
      goCkeditors = function(array) {
        return array.each(function(index, domEle) {
          var instance, options;
          options = $(this).data;
          if (instance = window.CKEDITOR.instances[this.id]) {
            instance.destroy(true);
          }
          window.CKEDITOR.replace(this, options['options']);
          return $(this).addClass('ckeditored');
        });
      };
      array = $('form [data-richtext=ckeditor]').not('.ckeditored');
      if (array.length) {
        this.array = array;
        if (!window.CKEDITOR) {
          options = $(array[0]).data('options');
          window.CKEDITOR_BASEPATH = options['base_location'];
          $.getScript(options['jspath'], function(script, textStatus, jqXHR) {
            return goCkeditors(_this.array);
          });
        } else {
          goCkeditors(this.array);
        }
      }
      goCodeMirrors = function(array) {
        return array.each(function(index, domEle) {
          var textarea;
          options = $(this).data('options');
          textarea = this;
          return $.getScript(options['locations']['mode'], function(script, textStatus, jqXHR) {
            $('head').append('<link href="' + options['locations']['theme'] + '" rel="stylesheet" media="all" type="text\/css">');
            CodeMirror.fromTextArea(textarea, {
              mode: options['options']['mode'],
              theme: options['options']['theme'],
              lineWrapping: true
            });
            return $(textarea).addClass('codemirrored');
          });
        });
      };
      array = $('form [data-richtext=codemirror]').not('.codemirrored');
      if (array.length) {
        this.array = array;
        if (!window.CodeMirror) {
          options = $(array[0]).data('options');
          $('head').append('<link href="' + options['csspath'] + '" rel="stylesheet" media="all" type="text\/css">');
          $.getScript(options['jspath'], function(script, textStatus, jqXHR) {
            return goCodeMirrors(_this.array);
          });
        } else {
          goCodeMirrors(this.array);
        }
      }
      goBootstrapWysihtml5s = function(array) {
        return array.each(function() {
          $(this).addClass('bootstrap-wysihtml5ed');
          $(this).closest('.controls').addClass('well');
          return $(this).wysihtml5();
        });
      };
      array = $('form [data-richtext=bootstrap-wysihtml5]').not('.bootstrap-wysihtml5ed');
      if (array.length) {
        this.array = array;
        if (!window.wysihtml5) {
          options = $(array[0]).data('options');
          $('head').append('<link href="' + options['csspath'] + '" rel="stylesheet" media="all" type="text\/css">');
          return $.getScript(options['jspath'], function(script, textStatus, jqXHR) {
            return goBootstrapWysihtml5s(_this.array);
          });
        } else {
          return goBootstrapWysihtml5s(this.array);
        }
      }
    }
  });

}).call(this);
