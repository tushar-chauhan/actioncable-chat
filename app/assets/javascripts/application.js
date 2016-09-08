// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function(){
  /**
     * Cookie plugin
     *
     * Copyright (c) 2006 Klaus Hartl (stilbuero.de)
     * Dual licensed under the MIT and GPL licenses:
     * http://www.opensource.org/licenses/mit-license.php
     * http://www.gnu.org/licenses/gpl.html
     *
     */
  $.cookie = function (name, value, options) {
   if (typeof value != 'undefined') { // name and value given, set cookie
     options = options || {};
     if (value === null) {
       value = '';
       options.expires = -1;
     }
     var expires = '';
     if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
       var date;
       if (typeof options.expires == 'number') {
         date = new Date();
         date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
       } else {
         date = options.expires;
       }
       expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
     }
     // CAUTION: Needed to parenthesize options.path and options.domain
     // in the following expressions, otherwise they evaluate to undefined
     // in the packed version for some reason...
     var path = options.path ? '; path=' + (options.path) : '';
     var domain = options.domain ? '; domain=' + (options.domain) : '';
     var secure = options.secure ? '; secure' : '';
     document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
   } else { // only name given, get cookie
     var cookieValue = null;
     if (document.cookie && document.cookie != '') {
       var cookies = document.cookie.split(';');
       for (var i = 0; i < cookies.length; i++) {
         var cookie = jQuery.trim(cookies[i]);
         // Does this cookie string begin with the name we want?
         if (cookie.substring(0, name.length + 1) == (name + '=')) {
           cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
           break;
         }
       }
     }
     return cookieValue;
   }
  };
  $('.alert').delay(3000).fadeOut('slow');

});
