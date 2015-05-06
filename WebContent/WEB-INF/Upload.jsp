<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:include page="Header.jsp"></jsp:include>

<div id="runningText" style="height: 28px; border: 1px solid; float: right; background-color: #e9967a; color: white; margin-top: 7px; font-size: 16px; font-family: Times New Roman;">
<c:set var="running" scope="request" value=""></c:set> 
	
	<c:forEach var="tweet" items="${tweets}">
		<c:set var="running" value="${running}${tweet}"></c:set>
	</c:forEach>
   <marquee behavior="scroll" direction="left" scrollamount="3">${running}</marquee>
   </div>
<div class="col-md-7 column" style="height:100%;">
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
   
   
	
	 
   <div id="cloudContent">    	
   		<div id="map-cloud"></div>
   </div>

</div>
<div class="col-md-5 column">

<div class="junbotron well" style = " width: 520px;  background-color: BLACK;">
<div class="page-header">
	<c:set var="keyed" value="${fn:replace(keyword,'+', ' ')}" />
   	<h3>Flickr Photos on: ${keyed}</h3>
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
        <img src="${photos.thumbnail()}" alt="Banana">
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
</div>
<!-- <p>  example</p>
<img src="https://farm3.staticflickr.com/2634/4046568058_0d7cffe35d.jpg"></img>
<a href="">upload here</a>
 <form method="POST" action="https://up.flickr.com/services/upload/" enctype="multipart/form-data" >
            File:
            <input type="file" name="photo" id="file" /> <br/>
            Destination:
            <input type="text" value="d237da9ec0636440997bacda66e0ef9f" name="api_key"/>
            <input type="text" value="72157650721793296-acbcdaaaa0ef0ff5" name="auth_token"/>
            <input type="text" value="95b3170154735d1eccbf9fa15662a6a1" name="api_sig"/>
            </br>
            <input type="submit"  id="upload" />
        </form>
        
        <h3>File Upload:</h3>
Select a file to upload: <br />
<form action="UploadServlet" method="post"
                        enctype="multipart/form-data">
<input type="file" name="file" size="50" />
<br />
<input type="submit" value="Upload File" />
</form>

<div style="width:500px;height:500px;text-align:center;margin:auto;" ><object width="500" height="500" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"  codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,40,0"> <param name="flashvars" value="offsite=true&amp;lang=en-us&amp;page_show_url=%2Fphotos%2Fshow&amp;page_show_back_url=%2Fphotos%2F&amp;tags=ottawa" /> <param name="allowFullScreen" value="true" /> <param name="src" value="https://www.flickr.com/apps/slideshow/show.swf?v=71649" /> <embed width="500" height="500" type="application/x-shockwave-flash" src="https://www.flickr.com/apps/slideshow/show.swf?v=71649" flashvars="offsite=true&amp;lang=en-us&amp;page_show_url=%2Fphotos%2Fshow&amp;tags=ottawa" allowFullScreen="true" /> </object><br /><small>Created with <a href="http://www.flickrslideshow.com">flickr slideshow</a>.</small></div>

<a href="">show related pics</a>
<a href="">get friends</a> -->


</div>


<jsp:include page="Footer.jsp"></jsp:include>