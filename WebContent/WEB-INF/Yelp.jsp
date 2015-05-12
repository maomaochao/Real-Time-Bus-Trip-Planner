<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<p> welcome ${user.getName()}</p> 
<c:if test="${not empty yelps}">
<div class="panel panel-danger">
<div class="panel-heading">
    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>  &nbsp; &nbsp;List
  </div>
<div class="panel-body">
<c:forEach var="yelp" items="${yelps}">
	<img  src = "${yelp.photo}"> </img>
   
	<p style="font-size:medium; color:red">
		${yelp.name}</br>
	</p>
</c:forEach>  </div>
  </div>
  </c:if>
</body>
</html>