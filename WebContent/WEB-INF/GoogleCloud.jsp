<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="random" class="java.util.Random" scope="application"/>
<jsp:include page="Header.jsp"></jsp:include>

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
        data.addRows(${num});
        <c:set var="rowNum" value="${0}"/> 
        <c:forEach var="trends" items="${twitTrends}">
        	data.setCell(${rowNum}, 0, '${trends}');
        	<c:set var="url" value="http://localhost:8080/Task8/upload.do?keyword=${trends}|${woeid}"/>
        	data.setCell(${rowNum}, 1, '${url}');
        	<c:set var="rowNum" value="${rowNum + 1}"/>
        </c:forEach>
        
     	// Instantiate our table object.
        var vis = new gviz_word_cumulus.WordCumulus(document.getElementById('map-cloud'));

        // Draw our table with the data we created locally.
        vis.draw(data, {text_color: '#03070b', speed: 15, width:window.innerWidth, height:window.innerHeight});
               
     }
   </script>
   
   <%-- <div class="page-header">
     <h1>Folks of ${city} Like</h1>
   </div> --%>
   
   <div id="cloudContent">    	
   		<div id="map-cloud"></div>
   </div>
   
   <!-- <script type="text/javascript">

      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Keyword');
        data.addColumn('number', 'Number of Response');
        
        data.addRows([
		<c:forEach var="trends" items="${twitTrends}">
          ['${trends}', ${random.nextInt(100)}],
        </c:forEach>
        ]);

        // Set chart options
        var options = {/* 'title':'Top ${num} Twitter Chart', */
                       is3D: true};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script> -->

<jsp:include page="Footer.jsp"></jsp:include>