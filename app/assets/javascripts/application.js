// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap

//= require_tree .

	    $(window).resize(function() {

	  if ($(window).width() <= 979 && $(window).width() >=600){
	      setTimeout(function() {
	          $("#toggle").trigger('click');
	      },1);}

	       
	});
	  if ($(window).width() <= 979 && $(window).width() >=600){
	      setTimeout(function() {
	          $("#toggle").trigger('click');
	      },1);}

	     var width= $(window).width()/5
	      
	        $("div.logo").animate({
	    
	    textIndent: width,

	    
	  }, 3600 );


	//Google Analytics 
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

	  ga('create', 'UA-41955848-1', 'bechnu.com');
	  ga('send', 'pageview');

