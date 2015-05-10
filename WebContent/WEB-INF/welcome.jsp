<!DOCTYPE html>
<html lang "en">
<head>
	<meta charset = "utf-8" />
	<title>List App</title>
	
  <!-- Include jQuery Mobile stylesheets -->
  <link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">

  <!-- Include the jQuery library -->
  <script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

  <!-- Include the jQuery Mobile library -->
  <script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>

  <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
	<style>
    img.fullscreen {max-height:100%; max-width" 100%;}
    #map-page, #map-canvas { width: 100%; height: 100%; padding: 0; }
  </style>
  <script type="text/javascript">
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
              var steps = response.routes[0].legs[0].steps;
              var time = response.routes[0].legs[0].duration.value;
              var stepCount = steps.length;
              var validStep = 0;
              for (var i = 0; i < stepCount; i++) {
                  if (steps[i].transit === undefined) continue;
                  //alert(JSON.stringify(steps[i], null, 4));
                  validStep++;
                  var lineName = steps[i].transit.line.short_name;
                  if (lineName === undefined) continue;
                  var instructions = steps[i].instructions;
                  var content = "<div data-role='collapsible' id='routes" + i + "'><h3>"  + lineName + "</h3><p>" + instructions + "</p></div>";

              var summary = "<p>There are " + validStep + " steps. The trip takes " + Math.floor(time / 60) + " minutes. </p>";
              $("#routes").empty();
              $("#routes").prepend( summary );
              $("#routes").append( content ).collapsibleset('refresh');
              };
          }
      });
    }
  // window.onload = calcRoute;
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
  </script>
</head>

<body>
<div data-role="page" id="main">
<header data-role="header">
  <h1> Port Authority APP</h1>
</header>
<article data-role="content">
<div data-role="header" data-theme="b">
  <h1>My Favorite Route</h1>
  </div>
<div data-role="content" data-theme="e">
<form method="post" action="demoform.asp">
      <fieldset data-role="fieldcontain">
        <label for="route">Route Choose:</label>
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
    </form>

     <table data-role="table" class="ui-responsive">
      <thead>
        <tr>
          <th>RouteID</th>
          <th>RouteName</th>
          <th>From</th>
          <th>To</th>
          <th>Next Arrival</th>
          <th>Minutes left</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td>61A to school</td>
          <td>4742 Centre Avenue</td>
          <td>CMU</td>
          <td>2:55 PM</td>
          <td>2 min</td>
        </tr>
      </tbody>
    </table>
</div>
<br>

<div data-role="header" data-theme="b">
  <h1>Search for Route</h1>
  </div>
  <button class="ui-btn" onclick="getCoordinates()">Get Current Location</button>
<form method="post" action="#">
      <div data-role="fieldcontain">
        <label for="lname">From: </label>
        <input type="text" name="lname" id="lname" placeholder="Your Location"> 
        <label for="fname">To  : </label>
        <input type="text" name="fname" id="fname">
      </div><p style="text-align: center;">
</form>
<button class="ui-btn" onclick="calcRoute()">Search</button>
<br>


<div data-role="collapsible-set" data-content-theme="d" id="routes">
</div>

<br>
<br>
  <ul data-role="listview">
    <li>
      <a href="yelp.do">
      <h1>Where to Eat</h1>
      <img src="img/fork.png" alt="bus3" />
      <p>Finding places to eat?</p>
      </a>
    </li>
  </ul>
</article>
<footer data-role="footer" data-position="fixed">
  <nav data-role="navbar">
    <ul>
      <li><a href="#main" data-icon="home">home</a></li>
      <li><a href="#map" data-icon="grid">Maps</a></li>
      <li><a href="#info" data-icon="info">Info</a></li>
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

<div data-role="page" id="map">
<header data-role="header">
  <a href="#main" data-icon="home" data-icon-iconpos="notext">Home</a>
  <h1>Map</h1>
</header>
<p>
  <img src="http://maps.googleapis.com/maps/api/staticmap?center= 43.60621, -116.278&zoom=15&size=300x300&markers=color:red%7Clabel:A%7C 43.60621, -116.278 &maptype=roadmap18&sensor=false">


</p>
</div> <!--end of page -->

<div data-role="page" id="info">
<header data-role="header">
  <a href="#main" data-icon="home" data-icon-iconpos="notext">Home</a>
  <h1>Information</h1>
</header>
<p> This is a test page for task 13</p>
</div> <!--end of page -->
</body>
</html>