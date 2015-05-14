<html lang "en">
<head>
<meta charset = "utf-8" />
	<title>Live Bus Map</title>
	
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
</head>


<body>
<div data-role="page" id="map">
<header data-role="header">
  <a href="#main" data-icon="home" data-icon-iconpos="notext">Home</a>
  <h1>Map</h1>
</header>

<iframe src="http://pitlivebus.com" width="480" height="660" seamless></iframe>
</div>
</body>