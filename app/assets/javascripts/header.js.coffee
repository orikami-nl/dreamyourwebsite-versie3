next = home_li_web: "#home_li_concept", home_li_concept: "#home_li_mobile", home_li_mobile: "#home_li_web"
mapping = home_banner_web: "#home_li_web", home_banner_concept: "#home_li_concept", home_banner_mobile: "#home_li_mobile"
bwmapping = home_li_web: "#home_banner_web", home_li_concept: "#home_banner_concept", home_li_mobile: "#home_banner_mobile"
timer = "undefined"

jumpArrow = () ->
  b = $("#home-banner-arrow").css('backgroundPosition')
  c = b.replace(/px/g,'')
  d = c.split(' ')
  e = (parseInt(d[1])+60) % 180
  f = "0px " + e + "px"
  $("#home-banner-arrow").css('backgroundPosition', f)

jumpActive = (current) =>
  indicator = mapping[current.attr("id")]
  d = $(indicator)
  e = next[d.attr("id")] 
  f = $(e)
  d.toggleClass("active-li")
  f.toggleClass("active-li")

rockActive = (currentli) =>
  $(".active-li").toggleClass("active-li") 
  currentli.toggleClass("active-li")

rockBanner = (current) =>
  if $(".home-banner-element:first").attr("id")!=current.attr("id")
     slideBanner($(".home-banner-element:first")) 
  if $(".home-banner-element:nth-child(2)").attr("id")!=current.attr("id")
     slideBanner($(".home-banner-element:nth-child(2)")) 

slideBanner = (current) ->
  a = current.outerHTML()
  current.slideUp =>
    last = $(".home-banner-element-last")
    last.after(a)
    newlast = last.next()
    current.toggleClass("home-banner-element home-banner-element-redundant")
    last.toggleClass("home-banner-element-last home-banner-element")
    newlast.toggleClass("home-banner-element home-banner-element-last")
    $(".home-banner-element-redundant").remove()

runSlider = () ->
  current = $(".home-banner-element:first")
  slideBanner(current)
  jumpActive(current)

jQuery -> $(".home-banner-element").live 'click', (event) -> 
  current = $(this)
  slideBanner(current)

jQuery -> $("#home-banner-fixed").live 'click', (event) -> 
  current = $("#home_banner_web")
  slideBanner(current)
    
jQuery -> $("#home-banner-categories li").live 'click', (event) ->
  clearInterval(timer)
  currentli = $(this)  
  rockActive(currentli)
  current = bwmapping[currentli.attr("id")]
  rockBanner($(current))   
  timer = setInterval(runSlider, 10000)

jQuery -> 
  clearInterval(timer) 
  timer = setInterval(runSlider, 5000)


