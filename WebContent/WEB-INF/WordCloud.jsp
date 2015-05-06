<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
    <script type="text/javascript" src="http://www.google.com/jsapi"></script>
    <script type="text/javascript" src="http://word-cumulus-goog-vis.googlecode.com/svn/trunk/wordcumulus.js"></script>
    <script type="text/javascript" src="http://word-cumulus-goog-vis.googlecode.com/svn/trunk/swfobject.js"></script>
    <script type="text/javascript">
      google.load("visualization", "1");

      // Set callback to run when API is loaded
      google.setOnLoadCallback(drawVisualization);

      // Called when the Visualization API is loaded.
      function drawVisualization() {

        // Create and populate a data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Tag');
        data.addColumn('string', 'URL');
        data.addRows(6);
        data.setCell(0, 0, 'Aayush');
        data.setCell(0, 1, 'http://localhost:8080/Task8/wordCloud.do');
        data.setCell(1, 0, 'Thomas');
        data.setCell(1, 1, 'http://localhost:8080/Task8/wordCloud.do');
        data.setCell(2, 0, 'Sthepanie');
        data.setCell(2, 1, 'http://localhost:8080/Task8/wordCloud.do');
        data.setCell(3, 0, 'Chang');
        data.setCell(3, 1, 'http://localhost:8080/Task8/wordCloud.do');
        data.setCell(4, 0, 'Ahmad');
        data.setCell(4, 1, 'http://localhost:8080/Task8/wordCloud.do');
        
        var runIt = getLocation();
  	  
    	function getLocation() {
    		if (navigator.geolocation) {
    	  		navigator.geolocation.getCurrentPosition(showPosition);
    	  	} else { 
    	  		return "Geolocation is not supported by this browser.";
    	  	}    	  	
    	}

    	function showPosition(position){ 
    		var text = position.coords.latitude + "/" + position.coords.longitude;
    		data.setCell(5, 0, 'Your location: ' + text);
            data.setCell(5, 1, 'http://localhost:8080/Task8/wordCloud.do');
            /* alert(text); */
            
         // Instantiate our table object.
            var vis = new gviz_word_cumulus.WordCumulus(document.getElementById('mydiv'));

            // Draw our table with the data we created locally.
            vis.draw(data, {text_color: '#ff4444', speed: 50, width:600, height:600});
    	}       
       }
   </script>
  </head>

  <body>
          <div> <h3>Top Ten Trending Tweets</h3></div>
  
        <div id="mydiv"></div>
        
  </body>
</html>