<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- Include meta tag to ensure proper rendering and touch zooming -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Include jQuery Mobile stylesheets -->
<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css">

<!-- Include the jQuery library -->
<script src="http://code.jquery.com/jquery-1.11.2.min.js"></script>

<!-- Include the jQuery Mobile library -->
<script
	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<title>Trip Planner</title>
</head>
<body>

	<div data-role="page" data-theme="b">

		<div data-role="header">
		<a href="welcome.do" class="ui-btn ui-icon-home ui-btn-icon-left"
				>Home</a>
			<a href="#" class="ui-btn ui-icon-home ui-btn-icon-left"
				data-rel="back">Back</a>
			<h1>Bus Trip Planner</h1>
		</div>

		<div>
			<h3>Team 15 Recommendations:</h3>
			<ul data-role="listview" data-inset="true">

				<c:if test="${not empty yelps}">

					<c:forEach var="yelp" items="${yelps}">
						<li><a href="${yelp.url}"> <img src="${yelp.photo}"
								style="padding-left: 20; padding-top: 20;">
								<img src="${yelp.rank}"
								style="padding-left: 20; padding-top: 20;">
								<div> 	
								<h2 style="float:left">${yelp.name}</h2>
								
								
								<h2 style="float:right">${yelp.time} minutes</h2>
		                       
								</div>
								 <div style="clear:both"> </div>
							  
								<p style="float:left">${yelp.address}</p>
								 <div style="clear:both"> </div>
							  


						</a></li>
					</c:forEach>

				</c:if>



			</ul>
		</div>

	<footer data-role="footer" data-position="fixed">
  <nav data-role="navbar">
    <ul>
    
      <li><a href="yelp.do?cate=restaurants"data-icon="home" >Food</a></li>
      <li><a href="yelp.do?cate=bars" data-icon="home">Bars</a></li>
       <li><a href="yelp.do?cate=barbers" data-icon="home">Beauty</a></li>
      <li><a href="yelp.do?cate=active"data-icon="home"> Active</a></li>
    </ul>
  </nav>
</footer>

	</div>

	<p>welcome ${user.getName()}</p>
	
	<div data-role="page" id="map">
<header data-role="header">
  <a href="#main" data-icon="home" data-icon-iconpos="notext">Home</a>
  <h1>Map</h1>
</header>
<!-- <p>
  <img src="http://maps.googleapis.com/maps/api/staticmap?center= 43.60621, -116.278&zoom=15&size=300x300&markers=color:red%7Clabel:A%7C 43.60621, -116.278 &maptype=roadmap18&sensor=false">


</p> -->
<iframe src="http://pitlivebus.com" width="480" height="660" seamless></iframe>
</div> <!--end of page -->




</body>
</html>