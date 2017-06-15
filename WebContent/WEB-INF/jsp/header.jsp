<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title> &raquo;Migration Skill Assessment &laquo;</title>
<link rel="stylesheet" href="css/main.css" type="text/css"/>
<link rel="stylesheet" href="css/bootstrap.css" type="text/css"/>
<link rel="stylesheet" href="css/nivo-slider.css" type="text/css" media="screen" />
<link rel="stylesheet" href="themes/light/light.css" type="text/css" media="screen" />

<script type="text/javascript" src="js/jquery-1.9.0.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<!-- <script type="text/javascript" src="scripts/jquery-1.9.0.min.js"></script>-->
<script type="text/javascript" src="js/jquery.nivo.slider.js"></script>
<script type="text/javascript" src="js/jquery.totemticker.js"></script>
<script type="text/javascript">

$(document).ready(function() {

	$('.dropdown-toggle').dropdown();

	 $('#slider').nivoSlider({
        effect: 'random', // Specify sets like: 'fold,fade,sliceDown'
        slices: 8, // For slice animations
        boxCols: 5, // For box animations
        boxRows: 5, // For box animations
        animSpeed: 920, // Slide transition speed
        pauseTime: 3500, // How long each slide will show
        startSlide: 0, // Set starting Slide (0 index)
        directionNav: false, // Next & Prev navigation
        controlNav: true, // 1,2,3... navigation
        controlNavThumbs: false, // Use thumbnails for Control Nav
        pauseOnHover: true, // Stop animation while hovering
        manualAdvance: false, // Force manual transitions
        prevText: 'Prev', // Prev directionNav text
        nextText: 'Next', // Next directionNav text
        randomStart: false, // Start on a random slide
        beforeChange: function(){}, // Triggers before a slide transition
        afterChange: function(){}, // Triggers after a slide transition
        slideshowEnd: function(){}, // Triggers after all slides have been shown
        lastSlide: function(){}, // Triggers when last slide is shown
        afterLoad: function(){} // Triggers when slider has loaded
    });

$(function(){
			$('#vertical-ticker').totemticker({
				row_height	:	'100px',
				next		:	'#ticker-next',
				previous	:	'#ticker-previous',
				stop		:	'#stop',
				start		:	'#start',
				mousestop	:	true,
				speed		:	500

			});
		});


});

</script>


</head>

<body>
<div class="container">

  <!--header wrapper -->

  <header class="row-fluid header_wrap">
    <div class="span4"><a href="#" class="logo" >eShop</a></div>
    <div class="span6 pull-right">
       <div class="span6 contacts pull-right">
        <div class="font_14 pull-left">Create Account | Login</div>

      </div>
    </div>
  </header>

  <!--header wrapper end -->

  <!--main menu -->

  <nav class="navbar">
    <ul class="nav">
      <li class="active"><a href="index.html">Quick Shop</a></li>
      <li class="dropdown"><a href="what-we-do.html" >View Cart</a></li>
      <li ><a href="benifits.html">Checkout</a></li>
      <li class="dropdown"><a href="fees.html" >Delivery Info</a></li>
    </ul>
  </nav>

  <!--main menu end -->
  <div class="clearfix"></div>

  <!--contents wrapper -->
  <div class="row-fluid contents">
  </div>
<div class="clearfix"></div>
<footer class="footer-wrap">

<div class="container footerbg">



<ul class="footerlinks">
<li><a href="#">Home</a>  </li>
<li><a href="#">What  we do</a> </li>
<li><a href="#">About</a>  </li>
<li><a href="#">Contact us</a>  </li>
<li><a href="#">Legal</a>  </li>
</ul>
<div class="span4 pull-left socialbookmark">©2014 . All rights reserved. </div>
<div class="span3 pull-right socialbookmark">
<div class="span1 pull-left">Follow us </div>
<span>

<a href="#" class="facebook">facebook</a>
<a href="#"  class="twitter">Twitter</a>


</span>
</div>
</div>

 </footer>
 </div>
</body>
</html>
