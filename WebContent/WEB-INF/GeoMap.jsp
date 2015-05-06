<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> --%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="initial-scale=1.0, user-scalable=no">
<meta charset="utf-8">
<title>Maven Trends</title>
<link class="cssdeck" rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/font-awesome.min.css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" class="cssdeck">
<link rel="stylesheet" href="css/bootstrapValidator.min.css" />
<link href="css/carousel.css" rel="stylesheet">
<link href="css/style-index.css" rel="stylesheet">

<style>
 body {
	background: url('img/background1.jpg');
	background-attachment: fixed;
	margin: 0;
	background-size: cover;
	background-repeat: no-repeat;
	display: compact;
	font: 13px/18px "Helvetica Neue", Helvetica, Arial, sans-serif;
	height: 100%;
}

#bar{
	background-color: #4099ff;
  	padding: 0 90px;
	height: 65px;
	box-shadow: 0px 2px 2px #606366;
}

 html, body, #map-canvas {
        height: 100%;
        padding: 0px
      }
</style>

 <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
 
 <script>
 
 		var map;

		function initialize() {
   			var mapOptions = {
     			zoom: 15
   			};
   			
   			map = new google.maps.Map(document.getElementById('map-canvas'),mapOptions);

   			// Try HTML5 geolocation
   			if(navigator.geolocation) {
     			navigator.geolocation.getCurrentPosition(function(position) {
       				var pos1 = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
       				/* var pos2 = new google.maps.LatLng(position.coords.latitude+0.003000,position.coords.longitude+0.003000); */

       				var infowindow = new google.maps.InfoWindow({
         								map: map,position: pos1
         						   	   ,content: '<a href="googleCloud.do">' + 'You are here' + '</a>'
       				});
       				
       				/* var infowindow = new google.maps.InfoWindow({
							map: map,position: pos2
					   	   ,content: 'Nearest Location'
					}); */

       				map.setCenter(pos1);
     			}, function() {
       				handleNoGeolocation(true);
     			   });
   			} else {
     		 	// Browser doesn't support Geolocation
     			handleNoGeolocation(false);
   			}
 		}

 		function handleNoGeolocation(errorFlag) {
   			if (errorFlag) {
     			var content = 'We apologized, we cannot locate your current location';
  			} else {
     			var content = 'Your browser doesn\'t support geolocation.';
   			}

  			var options = {
     						map: map,
     						position: new google.maps.LatLng(60, 105),
     						content: content
   			};

   			var infowindow = new google.maps.InfoWindow(options);
   			map.setCenter(options.position);
 		}

 		google.maps.event.addDomListener(window, 'load', initialize);
 
 </script>
</head>
<body>
<Nav class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container-fluid">
		<!--  Brand and toggle get grouped for better mobile display -->
		<div class="navbar-header " style="color: blue;">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
				<span class="sr-only"> Toggle navigation </span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
		</div>
		<!-- Collect the nav links, forms, and other content for toggling -->
		<div class="collapse navbar-collapse navbar-right navbar-ex1-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="#about">About</a>
                    </li>
                    <li><a href="#services">Services</a>
                    </li>
                    <li><a href="#contact">Contact</a>
                    </li>
                    <li><a href="logout.do">Logout</a>
                   </li>
                    <li><a href="Cus_ViewAccount.do">Hello, ${customer.firstName}
					${customer.lastName}!</a>
                   </li>           
                </ul>
        </div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a id="logo-outer" href="login.do"><img alt="logo"
						id="logo" src="img/logo.png">Maven Trends</a>
				</li>
			</ul>
		</div>
		<div style="position:centre">	
			<a href="https://twitter.com/intent/tweet?button_hashtag=MavenTrends&text=Wow!%20I%20found%20the%20trending%20topic%20near%20my%20place." class="twitter-hashtag-button" data-size="large">Tweet #MavenTrends</a>
				<script>
					!function(d, s, id) {
						var js, fjs = d.getElementsByTagName(s)[0], p = /^http:/
								.test(d.location) ? 'http' : 'https';
						if (!d.getElementById(id)) {
							js = d.createElement(s);
							js.id = id;
							js.src = p + '://platform.twitter.com/widgets.js';
							fjs.parentNode.insertBefore(js, fjs);
						}
					}(document, 'script', 'twitter-wjs');
				</script>
		</div>
</div>
</nav>
<div id="map-canvas"></div>
</body>
</html>