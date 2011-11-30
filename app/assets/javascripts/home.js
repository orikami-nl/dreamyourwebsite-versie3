var slideWidth;
var numberOfSlides;
var slides;
var currentPosition;

$(document).ready(function(){
  currentPosition = 0;
  slideWidth = $(window).width();
  slides = $('.home-banner-element');
  numberOfSlides = slides.length;

  // Remove scrollbar in JS
  $('#home-banner-container').css('overflow', 'hidden');
  $('#home-banner-container').css('width',slideWidth);

  // Wrap all .slides with #slideInner div
  slides
  .wrapAll('<div id="slideInner"></div>')
  // Float left to display horizontally, readjust .slides width
  .css({
    'float' : 'left',
    'width' : slideWidth
  });

  // Set #slideInner width equal to total width of all slides
  $('#slideInner').css('width', slideWidth * numberOfSlides);

  // Insert left and right arrow controls in the DOM
  // $('#home-strip')
  //   .prepend('<a href="#" class="control" id="left">Move left</a>')
  //   .append('<a href="#" class="control" id="right">Move right</a>');

  $(document).everyTime(5000,'bannertimer',function(i) {
		  currentPosition = currentPosition + 1;
					// Move slideInner using margin-left
      $('#slideInner').animate({
        'marginLeft' : slideWidth*(-(currentPosition % numberOfSlides))
      });

      $("#home-banner-bullets ul li").removeClass("active-bullet");
      $("#home-banner-bullets ul li:nth-child("+((currentPosition % numberOfSlides)+1)+")").addClass("active-bullet");
				}); 
      
  // // Create event listeners for .controls clicks
  // $('.control')
  //   .bind('click', function(){

  //    $(document).stopTime('bannertimer');
  //   // Determine new position
  //     currentPosition = ($(this).attr('id')=='right')
  //   ? currentPosition+1 : currentPosition-1;

  //     // Move slideInner using margin-left
  //     $('#slideInner').animate({
  //       'marginLeft' : slideWidth*(-(currentPosition % numberOfSlides))
  //     });

  //     $("#home-banner-bullets ul li").removeClass("active-bullet");
  //     $("#home-banner-bullets ul li:nth-child("+((currentPosition % numberOfSlides)+1)+")").addClass("active-bullet");

  //   });

  	$('.bullet')
    .bind('click', function(){
    // Determine new position
    $(document).stopTime('bannertimer');
      currentPosition = ($(this).index());

      // Move slideInner using margin-left
      $('#slideInner').animate({
        'marginLeft' : slideWidth*(-(currentPosition % numberOfSlides))
      });

      $("#home-banner-bullets ul li").removeClass("active-bullet");
      $("#home-banner-bullets ul li:nth-child("+((currentPosition % numberOfSlides)+1)+")").addClass("active-bullet");

    });

    $('.fade').hover(function() { 
    $(this).stop().animate({"opacity": 1}); 
    },function() { 
        $(this).stop().animate({"opacity": 0}); 
    });

  });



$(window).resize(function(){
	slideWidth = $(window).width();
	$('#home-banner-container').css('width',slideWidth);

	// Wrap all .slides with #slideInner div
  slides.css({
    'float' : 'left',
    'width' : slideWidth
  });
  	$('#slideInner').css('width', slideWidth * numberOfSlides);	
  	  
  	  $('#slideInner').css({
        'margin-left' : slideWidth*(-(currentPosition % numberOfSlides))
      });
});