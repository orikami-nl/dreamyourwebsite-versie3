jQuery.extend({
    skype : function(failureFunction) {
        var $ = jQuery;

        if ($.browser.safari || $.browser.opera) {
            return true;
        } else if ($.browser.msie) {
            try {
                if (new ActiveXObject("Skype.Detection")) return true;
            } catch(e) { }
        } else {
            if (typeof(navigator.mimeTypes["application/x-skype"]) == "object") {
                return true;
            }
        }
        $('a[href^="skype:"]').click(function() {
            failureFunction();
            return false;
        });
        return false;
    }
});
   
jQuery(function($) {
    $.skype(function() {
        // this function gets called if they don't have skype.
        alert("Looks like you don't have skype. Bummer.");
    });
});
  
function isSkypeInstalled(str) {
    try {
      /*@cc_on
      //The Microsoft way, thanks to the conditional comments only run in IE
      if (new ActiveXObject("Skype.Detection")) return true;
      @*/

      //Tested for firefox on win
      if (navigator.mimeTypes["application/x-skype"]) return true;
    }
    catch(e){}
    return false;
}