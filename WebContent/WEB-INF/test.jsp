<!DOCTYPE html>
<html>
  <head>
    <title>Place searches</title>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
    </style>
      <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&libraries=places"></script>
    
    <script type="text/javascript">
    function calcRoute() {
      var directionsService = new google.maps.DirectionsService();
      var start = "1510 Shady Avenue, Pittsburgh, PA";
      var end = "Carnegie Mellon University";
      //var start = document.getElementById("lname").value;
     // var end = document.getElementById("fname").value;
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

var map;
var infowindow;

function initialize() {
  var pyrmont = new google.maps.LatLng(40.439722, -79.976389);

  map = new google.maps.Map(document.getElementById('map-canvas'), {
    center: pyrmont,
    zoom: 15
  });

  var request = {
    location: pyrmont,
    radius: 50000,
    name: 'giant eagle'

  };
  infowindow = new google.maps.InfoWindow();
  var service = new google.maps.places.PlacesService(map);
  service.nearbySearch(request, callback);
}

function callback(results, status) {
  if (status == google.maps.places.PlacesServiceStatus.OK) {
    for (var i = 0; i < results.length; i++) {
      createMarker(results[i]);
    }
  }
}

function createMarker(place) {
  var placeLoc = place.geometry.location;
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location
  });

  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(place.name);
    infowindow.open(map, this);
    calcRoute();
    
  });
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
  here
  <button data-inline="true" onclick="calcRoute()">Search</button>
  
  <div data-role="collapsible-set" data-content-theme="d" id="routes">
</div>
    <div id="map-canvas"></div>
  </body>
</html>