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
    function init() {
      var directionsService = new google.maps.DirectionsService();
      var start = "1510 Shady Avenue, Pittsburgh, PA";
      var end = "Carnegie Mellon University";
     // var start = document.getElementById("lname").value;
      //var end = document.getElementById("fname").value;
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
<body onload = "init()">
<button  onclick="init()">Search</button>
			
			<div data-role="collapsible-set" data-content-theme="d" id="routes">
</div>

</body>
</html>