<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html> 
	<head>
		<title>Login</title>
	</head>
	<body>
		<c:if test="${not empty message}"><jsp:include page="../messagedisplay.jsp" /></c:if>
		
		<div id="bd" style="margin-top: 35px;">
			<div class="page-title">
				<h3 style="margin:0">Please Log In</h3>
			</div>
			<jsp:include page="loginbox.jsp"/>
		</div>
		<div>
		<p>New customers, please
				<a href="${contextPath}/account/addCustomer">register</a>.</p>
		</div>
	</body>
</html>
