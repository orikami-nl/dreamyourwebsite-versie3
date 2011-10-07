mapping = webdesign: "#header-slider-1", marketing: "#header-slider-2", mobile: "#header-slider-3"
next = webdesign: "#marketing", marketing: "#mobile", mobile: "#webdesign"
timer = "undefined"

slideSwitch = () ->
  b = $(".active")
  c = next[b.attr("id")]
  d = $(c)
  $(b).delay(800).toggleClass("active inactive")
  $(d).delay(800).toggleClass("active inactive")
  $("#header-sliders .inactive").hide()  
  $(mapping[d.attr("id")]).show()

  
$ -> 
  clearInterval(timer) 
  timer = setInterval(slideSwitch, 5000);


$ -> $("#header-usps li").mouseenter -> 
  $(".active").toggleClass("active inactive") 
  $(this).toggleClass("active inactive") 
  $(mapping[this.id]).toggleClass("active inactive")
  $("#header-sliders .inactive").hide()
  $(mapping[this.id]).show()
  clearInterval(timer)
  timer = setInterval(slideSwitch, 5000);
  
$ -> 
  $('#parallax').jparallax({mouseResponse: true});
