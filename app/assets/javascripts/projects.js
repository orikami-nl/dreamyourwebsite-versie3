 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.
 // You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready(function() {

	/* Using custom settings */
	
	$("a#inline").fancybox({
		'onComplete': function(){  
    		$('#jmpress').jmpress({
    			fullscreen: false,
				duration: {
					defaultValue: 1000
				}
    		});
  		}
  	});

	/* Apply fancybox to multiple items */
	
	// $("a.group").fancybox({
	// 	'transitionIn'	:	'elastic',
	// 	'transitionOut'	:	'elastic',
	// 	'speedIn'		:	600, 
	// 	'speedOut'		:	200, 
	// 	'overlayShow'	:	false
	// });
	
});