<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Header</title>
</head>
<body>
		<div id="headerLinks">
					<c:choose>
					<c:when test="${shoppingCart.customer == null or shoppingCart.customer.id<=0}">
					<a href="${contextPath}/account/addCustomer">Create Account</a> |      
					<a href="${contextPath}/account/login.do">Login</a>
					</c:when>
					<c:otherwise>
					<a href="${contextPath}/account/addCustomer">${shoppingCart.customer.otherNames} ${shoppingCart.customer.lastName}</a> |      
					<a href="${contextPath}/account/logout.do">Logout</a>
					</c:otherwise>
					</c:choose>
		</div>
		
</body>
</html>