<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<title>Page Not Found</title>
<body>
	<h1>Page Not Found</h1>
	<h3>Message : ${message}</h3>	
	<p>We're sorry, couldn't find the requested page.</p>
	<c:choose>
					<c:when test="${startupHierarchyList == null or empty startupHierarchyList}">
					<a href="<c:url value="/initStartingSetup" />" >Home</a>
					</c:when>
					<c:otherwise>
					<a href="<c:url value="/shop?id=0" />" >Shop</a>
					</c:otherwise>
	</c:choose>
	
</body>
</html>
