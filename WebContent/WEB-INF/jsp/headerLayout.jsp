<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 

<html>
	<head>
	</head>
	<body>
		<tiles:insertAttribute name="headerLinks" />
		<tiles:insertAttribute name="banner" /> 
		<tiles:insertAttribute name="menu" />
		<tiles:insertAttribute name="headerFooter" />
	</body>
</html>
