<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html lang = "en">
<head>

	<meta charset = "utf-8" />
	<title>List App</title>
	
  <!-- Include jQuery Mobile stylesheets -->
  <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">

  <!-- Include the jQuery library -->
  <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

  <!-- Include the jQuery Mobile library -->
  <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>

<!--   <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
 -->	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
	<style>
    img.fullscreen {max-height:100%; max-width" 100%;}
    #map-page, #map-canvas { width: 100%; height: 100%; padding: 0; }
  </style>
  <script type="text/javascript">
 
  $(function() {
  	var input = document.getElementById("lname");
   	  var autocomplete = new google.maps.places.Autocomplete(input, { types: ['geocode'] });
   	  google.maps.event.addListener(autocomplete, 'place_changed', function() {
   	      var place = autocomplete.getPlace();
   	      input.place = place;
      console.log( "ready!" );
  		});
   	var input = document.getElementById("fname");
 	  var autocomplete = new google.maps.places.Autocomplete(input, { types: ['geocode'] });
 	  google.maps.event.addListener(autocomplete, 'place_changed', function() {
 	      var place = autocomplete.getPlace();
 	      input.place = place;
    console.log( "ready!" );
		});
  });


      
    function calcRoute() {
    	
    	
      var directionsService = new google.maps.DirectionsService();
      //var start = "1510 Shady Avenue, Pittsburgh, PA";
      //var end = "Carnegie Mellon University";
      var start = document.getElementById("lname").value;
      var end = document.getElementById("fname").value;
      var request = {
                      origin: start,
                      destination: end,
                      travelMode: google.maps.TravelMode.TRANSIT
                      };
      directionsService.route(request, function(response, status) {
          if (status == google.maps.DirectionsStatus.OK) {
              console.dir(response.routes);
              var steps = response.routes[0].legs[0].steps;
              var time = response.routes[0].legs[0].duration.value;
              var stepCount = steps.length;
              var validStep = 0;
              $("#favorites").empty();
              $("#routes").empty();
              for (var i = 0; i < stepCount; i++) {
                  if (steps[i].transit === undefined) continue;
                  //alert(JSON.stringify(steps[i], null, 4));
                  var lineName = steps[i].transit.line.short_name;
                  if (lineName === undefined) continue;
                  validStep++;
                  var instructions = steps[i].instructions;
                  //var content = "<div data-role='collapsible' id='routes" + i + "'><h3>"  + lineName + "</h3><p>" + instructions + "</p></div>";
                  var departTime = steps[i].transit.departure_time;
                  if (departTime === undefined) {
                    departTime = "No Info Available";
                  } else {
                    departTime = departTime.text;
                  }

var content = "<div data-role='collapsible' id='routes'" + i + "><h3>"  + lineName + "</h3><table data-role='table' class='ui-responsive' id='favorites'>"
      + "<thead><tr><th>RouteName</th><th>From</th><th>To</th><th>Next Arrival</th></tr></thead><tbody>"
      + "<tr><td>" + lineName + "</td><td>" + steps[i].transit.departure_stop.name + "</td><td>" + steps[i].transit.arrival_stop.name + "</td><td>" + departTime + "</td></tr></tbody></table></div>";


              $("#routes").append( content ).collapsibleset('refresh');
              };
              var summary = "<p>There are " + validStep + " steps. The trip takes " + Math.floor(time / 60) + " minutes. </p>";
              $("#routes").prepend( summary );
          }
      });
    }
  </script>
  <script type="text/javascript">
function getCoordinates() {    
  if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(showPosition);
  } else { 
      alert("Geolocation is not supported by this browser.");
  }
   
}


  function showPosition(position) {
    var lat = position.coords.latitude;
    var lng = position.coords.longitude;
    var latlng = new google.maps.LatLng(lat, lng);  
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({'latLng': latlng}, function(results, status) {
      document.getElementById("lname").value = results[1].formatted_address;
    });
  }
  window.onload = getCoordinates;
  </script>
  
  <script>
  // This is called with the results from from FB.getLoginStatus().
  function statusChangeCallback(response) {
    console.log('statusChangeCallback');
    console.log(response);
    // The response object is returned with a status field that lets the
    // app know the current login status of the person.
    // Full docs on the response object can be found in the documentation
    // for FB.getLoginStatus().
    if (response.status === 'connected') {
      // Logged into your app and Facebook.
      testAPI();
    } else if (response.status === 'not_authorized') {
      // The person is logged into Facebook, but not your app.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into this app.';
    } else {
      // The person is not logged into Facebook, so we're not sure if
      // they are logged into this app or not.
      document.getElementById('status').innerHTML = 'Please log ' +
        'into Facebook.';
    }
  }

  // This function is called when someone finishes with the Login
  // Button.  See the onlogin handler attached to it in the sample
  // code below.
  function checkLoginState() {
    FB.getLoginStatus(function(response) {
      statusChangeCallback(response);
    });
  }
  
  function logout() {
	  FB.logout(function(response) {
	        // Person is now logged out
	    });
	  
	  }
  

  window.fbAsyncInit = function() {
  FB.init({
    appId      : '1431404603842789',
    cookie     : true,  // enable cookies to allow the server to access 
                        // the session
    xfbml      : true,  // parse social plugins on this page
    version    : 'v2.2' // use version 2.2
  });

  // Now that we've initialized the JavaScript SDK, we call 
  // FB.getLoginStatus().  This function gets the state of the
  // person visiting this page and can return one of three states to
  // the callback you provide.  They can be:
  //
  // 1. Logged into your app ('connected')
  // 2. Logged into Facebook, but not your app ('not_authorized')
  // 3. Not logged into Facebook and can't tell if they are logged into
  //    your app or not.
  //
  // These three cases are handled in the callback function.

  FB.getLoginStatus(function(response) {
	  var user = '${user.name}';
	  console.log("user is "+user);
    if (user=="") statusChangeCallback(response);
  });

  };

  // Load the SDK asynchronously
  (function(d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
  }(document, 'script', 'facebook-jssdk'));

  // Here we run a very simple test of the Graph API after login is
  // successful.  See statusChangeCallback() for when this call is made.
  function testAPI() {
    console.log('Welcome!  Fetching your information.... ');
    FB.api('/me', function(response) {
      console.log('Successful login for: ' + response.name);
     
      $.ajax({
          url: 'login.do',
          data: {
              "userid" : response.id,
              "username" : response.name
          },
          type: 'POST'
      });
     // document.location.href="welcome.do";

    //location.reload();
    });
   
   // document.location.href="login.do?userid="+response.id+"&username="+response.name;
   
  
  
  }
</script>
</head>

<body>
<div data-role="page" id="main">
<header data-role="header">
<table>
<tr>
<td>
&ensp;
</td>
<td>
  <div align="center"> <h1> Real-time Bus planner</h1>&ensp;&ensp; </div>
  </td>
  <td>
  					<c:choose>
						<c:when test="${ (empty user) }">
					<div align="right">	 <fb:login-button scope="public_profile,email" onclick="checkLoginState();">
</fb:login-button></div>
    
      
							
						</c:when>
						<c:otherwise>
							<span class="menu-head">Welcome,&ensp;${user.name}&ensp;<a href="logout.do" onclick="logout();">Log Out</span>
							<br />

						</c:otherwise>
					</c:choose>
 
</td>
</tr>
</table>
</header>
<article data-role="content">

<div data-role="header" data-theme="g">
    <p> Please choose from saved routes:</p>
  
  </div>

  <!-- <button class="ui-btn" onclick="getCoordinates()">Get Current Location</button> -->
<form method="post" action="#">
  <fieldset data-role="fieldcontain">
        <label for="route">Favorite Route:</label>
        <select name="route" id="route">
         <option value="route1">61A to School</option>
         <option value="route2">61C to home</option>
         <option value="route3">to Airport</option>
         <option value="route4">from airport to home</option>
         <option value="route5">to movie theater</option>
         <option value="route6">back home from theater</option>
         <option value="route7">to downtown</option>
        </select>
      </fieldset>
      <table data-role="table" class="ui-responsive" id="favorites">
      <thead>
        <tr>
          <th>RouteName</th>
          <th>From</th>
          <th>To</th>
          <th>Next Arrival</th>
          <th >Minutes left</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>61A to school</td>
          <td>4742 Centre Avenue</td>
          <td>CMU</td>
          <td>2:55 PM @ Forbes Ave at Shady Ave</td>
          
          <td id = "timeleft"><font color="red">2 minutes</font></td>
        </tr>
      </tbody>
    </table>
      <div data-role="header" data-theme="g">
    <p> Or search for any routes:</p>
  
  </div>
      <div data-role="fieldcontain">
        <label for="lname">From: </label>
        <input type="text" name="lname" id="lname" placeholder="Your Location"> 
        <label for="fname">To  : </label>
        <input type="text" name="fname" id="fname">
        
      </div>
</form>
<div align="center">
<button data-inline="true" onclick="calcRoute()">Search</button>
<button  data-inline="true" onclick="calcRoute()">Add to Favorite</button>
</div>
<br>
     

<div data-role="collapsible-set" data-content-theme="d" id="routes">
</div>


</article>
<footer data-role="footer" data-position="fixed">
  <nav data-role="navbar">
    <ul>
      <li><a href="#main" data-icon="home">Home</a></li>
      <li><a href="map.do" data-icon="grid">Map</a></li>
       <li><a href="yelp.do" data-icon="star">Places</a></li>
      <!-- <li><a href="#info" data-icon="info">Info</a></li> -->
    </ul>
  </nav>
</footer>
</div> <!--end of page -->


<div data-role="page" id="bus3"> <!--page start for searching restaurants-->
  <div data-role="header">
    <a href="#main" data-icon="home" data-icon-iconpos="notext">Home</a>
    <h1>Bus Triper</h1>
  </div>

  <div data-role="main" class="ui-content">
      <div class="center-wrapper">
          <p>What do you want to do?</p>           
      </div>
      <form method="post" action="demoform.asp">
          <fieldset class="ui-field-contain">
              <label for="options" class="ui-hidden-accessible">Options</label>
              <select name="options" id="options">
                <option value="eat">Eat</option>
                <option value="night">Night</option>
                <option value="art">Art</option>
              </select>
          </fieldset>
      </form>
      <a href="list.html" class="ui-btn ui-icon-search ui-btn-icon-left ui-corner-all ui-shadow">Surprise Me</a>
  </div>

        <div data-role="footer">
            <h1>Team 15</h1>
        </div>
</div> <!--end of page -->


<!-- <div data-role="page" id="info">
<header data-role="header">
  <a href="#main" data-icon="home" data-icon-iconpos="notext">Home</a>
  <h1>Information</h1>
</header>
<p> This is a test page for task 13</p>
</div>  -->
</body>
</html>
