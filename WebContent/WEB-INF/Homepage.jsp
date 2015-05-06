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
   
	<div id="appContent" class="col-md-6 column affix" style = "position: absolute;
left: 0px;
top: 0px;
z-index: 8;
width: 917px;
">
		<div class="page-header" id="map-title">
   			<h3>Click on the map</h3>
   		</div>
		<div id="map-canvas"></div>
	</div>



    
    <div id="analyticsContent"  style = "position: relative;z-index: 9;	background-color: WHITE; width: 450px; overflow: scroll;" >
    	<div style = " margin: 20px;">
    	
    	<div class="page-header" id="chart-title">
   			<h3>Pics from Hot Location</h3>
   		</div>
    	
    	<div id="blueimp-gallery" class="blueimp-gallery">
    <!-- The container for the modal slides -->
    <div class="slides"></div>
    <!-- Controls for the borderless lightbox -->
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
    <!-- The modal dialog, which will be used to wrap the lightbox content -->
    <div class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">haha</h4>
                </div>
                <div class="modal-body next"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left prev">
                        <i class="glyphicon glyphicon-chevron-left"></i>
                        Previous
                    </button>
                    <button type="button" class="btn btn-primary next">
                        Next
                        <i class="glyphicon glyphicon-chevron-right"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="http://blueimp.github.io/Gallery/js/jquery.blueimp-gallery.min.js"></script>
<script src="js/bootstrap-image-gallery.min.js"></script>
<div id="links">

<c:forEach var="photos" items="${photos}">
	<a href="${photos}" title="${photos.id}" data-gallery>
        <img src="${photos.small()}" alt="Banana">
    </a>
</c:forEach>

<%-- <c:forEach var="tweet" items="${tweets}">
	<p style="font-size:medium; color:red">
=======
<c:forEach var="tweet" items="${tweets}">
	<p style="font-size:medium; color:grey">
>>>>>>> origin/master
	${tweet} </br>
	</p>
</c:forEach> --%>


    <!-- <a href="https://farm3.staticflickr.com/2634/4046568058_0d7cffe35d.jpg" title="" data-gallery>
        <img src="https://farm3.staticflickr.com/2634/4046568058_0d7cffe35d.jpg" alt="Banana">
    </a>
    <a href="images/apple.jpg" title="Apple" data-gallery>
        <img src="images/thumbnails/apple.jpg" alt="Apple">
    </a>
    <a href="images/orange.jpg" title="Orange" data-gallery>
        <img src="images/thumbnails/orange.jpg" alt="Orange"> 
    </a>-->
</div>
    	<div class="page-header" id="chart-title">
   			<h3>Tweets from Hot Location</h3>
   		</div>
   		
   		<c:forEach var="tweet" items="${homepagetweets}">
   		<div class="media">
        <a href="#" class="pull-left">
<!--             <img src="https://farm3.staticflickr.com/2859/10161609246_7c03cda038_s.jpg" class="media-object" alt="Sample Image">
 -->        </a>
        <div class="media-body">
            <h4 class="media-heading">${tweet.name} <small><i>from Location:Pittsburgh</i></small></h4>
            <p>${tweet.text}</p>
        </div>
    </div>
    <hr />
    </c:forEach>
    
   		<!-- <ul class="nav nav-pills nav-stacked" style =" background-color: WHITE;">
<li role="presentation" class="active"><<a href="#">Home</a></li>
  <li role="presentation"><a href="#">Profile</a></li>
  <li role="presentation"><a href="#">Messages</a></li></ul> -->
    	<!-- <div id="map-chart"></div> -->
    </div>
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