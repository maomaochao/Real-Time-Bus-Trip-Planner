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
<title>Insert title here</title>
</head>
<body>
	<div data-role="page">

		<div data-role="header">
			<a href="#" class="ui-btn ui-icon-home ui-btn-icon-left"
				data-rel="back">Back</a>
			<h1>Bus Triper</h1>
		</div>

		<div>
			<h3>Here are the best restaurants:</h3>
			<ul data-role="listview" data-inset="true">

				<c:if test="${not empty yelps}">

					<c:forEach var="yelp" items="${yelps}">
						<li><a href="routes.html"> <img src="${yelp.photo}"
								style="padding-left: 20; padding-top: 20;">
								<h2>${yelp.name}                15min</h2>
								<p>1607 Penn Ave Pittsburgh, PA 15222</p>
								<p>5:06 PM from Forbes Ave at Morewood Ave FS (Carnegie Mellon)</p>


						</a></li>
					</c:forEach>

				</c:if>



			</ul>
		</div>

		<div data-role="footer">
			<h1>Team 15</h1>
		</div>

	</div>

	<p>welcome ${user.getName()}</p>

</body>
</html>