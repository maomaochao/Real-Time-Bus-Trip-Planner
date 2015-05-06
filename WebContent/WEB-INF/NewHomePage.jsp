<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="Header.jsp"></jsp:include>
<style>
#twitterbutton {
display:none;
}
</style>
<script>
 
 		var map;
 		
 		function CenterControl(controlDiv, map, position) {

 			  // Set CSS for the control border
 			  var controlUI = document.createElement('div');
 			  controlUI.style.backgroundColor = '#eeeeee';
 			  controlUI.style.border = '2px solid #fff';
 			  controlUI.style.borderRadius = '3px';
 			  controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
 			  controlUI.style.cursor = 'pointer';
 			  controlUI.style.marginBottom = '22px';
 			  controlUI.style.marginRight = '5px';
 			  controlUI.style.textAlign = 'center';
 			  controlUI.title = 'Click to recenter the map';
 			  controlDiv.appendChild(controlUI);

 			  // Set CSS for the control interior
 			  var controlText = document.createElement('div');
 			  controlText.style.color = 'rgb(25,25,25)';
 			  controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
 			  controlText.style.fontSize = '16px';
 			  controlText.style.lineHeight = '38px';
 			  controlText.style.paddingLeft = '5px';
 			  controlText.style.paddingRight = '5px';
 			  controlText.innerHTML = 'My Location';
 			  controlUI.appendChild(controlText);

 			  // Setup the click event listeners: simply set the map to user location
 			  google.maps.event.addDomListener(controlUI, 'click', function() {
 			    map.setCenter(position)
 			  });

 			}

		function initialize() {
   			var mapOptions = {
     			zoom: 8,
     			disableDefaultUI: true
   			};
   			
   			map = new google.maps.Map(document.getElementById('map-canvas'),mapOptions);

   			// Try HTML5 geolocation
   			if(navigator.geolocation) {
     			navigator.geolocation.getCurrentPosition(function(position) {
       				var uLocate = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
       				
			var infowindow = new google.maps.InfoWindow(
											{
												map : map,
												position : uLocate,
												content : '<a href="googleCloud.do?lat='
													+ uLocate.lat()
													+ '&lng='
													+ uLocate.lng()
													+ '">'
													+ 'Click here to start finding top tweets or click anywhere in the map'
													+ '</a>'
										});

								/* var infowindow = new google.maps.InfoWindow({
									map: map,position: pos2
									   ,content: 'Nearest Location'
								}); */

								map.setCenter(uLocate);

								// Create the DIV to hold the control and
								// call the CenterControl() constructor passing
								// in this DIV.
								var centerControlDiv = document
										.createElement('div');
								var centerControl = new CenterControl(
										centerControlDiv, map, uLocate);

								centerControlDiv.index = 1;
								map.controls[google.maps.ControlPosition.RIGHT_BOTTOM]
										.push(centerControlDiv);
							}, function() {
								handleNoGeolocation(true);
							});
		} else {
			// Browser doesn't support Geolocation
			handleNoGeolocation(false);
		}

		google.maps.event.addListener(map, 'click', function(e) {
			placeMarker(e.latLng, map);
		});
	}

	function handleNoGeolocation(errorFlag) {
		if (errorFlag) {
			var content = '<a href="googleCloud.do?lat=40.4566772'
				+ '&lng=-79.93560780000001'
				+ '">'
				+ 'Click here to start finding top tweets or click anywhere in the map'
				+ '</a>'
		} else {
			var content = 'Your browser doesn\'t support geolocation.';
		}

		var options = {
			map : map,
			position : new google.maps.LatLng(40.4566772, -79.93560780000001),
			content : content
		};

		var infowindow = new google.maps.InfoWindow(options);
		map.setCenter(options.position);
	}

	function placeMarker(position, map) {
		var infowindow = new google.maps.InfoWindow({
			map : map,
			position : position,
			content : '<a href="googleCloud.do?lat=' + position.lat() 
					+ '&lng=' + position.lng() + '">'
					+ 'Want to see top twitter trends around this place?'
					+ '</a>'
		});
	}

	google.maps.event.addDomListener(window, 'load', initialize);
</script>
   
	<div id="appContent" class="col-md-8 column" style = "position: absolute;
left: 0px;
top: 0px;
z-index: 8;
width: 917px;
height: 315px;">
		<div class="page-header" id="map-title">
   			<h3>Click on the map</h3>
   		</div>
		<div id="map-canvas"></div>
	</div>
    
    <div id="analyticsContent" class="col-md-4 column">
    	<div class="page-header" id="chart-title">
   			<h3>Most Searched Cities</h3>
   		</div>
    	<div id="map-chart"></div>
    </div>
    
    <script type="text/javascript">
		google.load('visualization', '1.0', {'packages':['corechart']});
	    google.setOnLoadCallback(drawChart);
	    
	    var w= document.getElementById('analyticsContent').clientWidth;
	    var h = document.getElementById('analyticsContent').clientHeight 
	    	- document.getElementById('chart-title').offsetHeight;
	    
	    console.log(w);
	    console.log(h);
	
	    function drawChart() {
	
	      var data = google.visualization.arrayToDataTable([
	        ['City','Number of Search'],
	        <c:forEach var="city" items="${topten}">
	          ['${city.locName}', ${city.count}],
	        </c:forEach>
	      ]);
	
	      var options = {
	        title: '',
	        hAxis: {
	          title: 'Number of Clicks',
	          minValue: 0
	        },
	        vAxis: {
	          title: 'City'
	        },
	        is3D: true
	      };
	
	      var chart = new google.visualization.BarChart(document.getElementById('map-chart'));
	
	      chart.draw(data, options);
	    }
    </script>

<jsp:include page="Footer.jsp"></jsp:include>