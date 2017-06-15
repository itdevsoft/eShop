<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html>
	<head>
		<title>eShop - <tiles:insertAttribute name="title" ignore="true" /></title>
		<link type="text/css" href="${contextPath}/resources/css/jquery-ui-1.8.16.custom.css" rel="stylesheet" />	
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-1.7.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/jquery-ui-1.8.16.custom.min.js"></script>
		<script type="text/javascript" src="${contextPath}/resources/js/extra.js"></script>
		<link type="text/css" href="${contextPath}/resources/css/extra.css" rel="stylesheet" />
		<link type="text/css" href="${contextPath}/resources/css/extra.css" rel="stylesheet" />
		<link type="text/css" href="${contextPath}/resources/css/main.css" rel="stylesheet" />
		<link type="text/css" href="${contextPath}/resources/css/bootstrap.css" rel="stylesheet" />
	<script type="text/javascript">
		$(document).ready(function() {
			$("a", ".buttons").button();
			$(".ui-button-text-headerFooter").attr("style", "padding:0.02em 0.02em;");
			$(".ui-button-text-topNavigation").attr("style", "padding:0.002em 0.002em;");
			$("#highlight").addClass("ui-state-focus");
		});
	</script>
	
	</head>
	<body>
		<div class="container">

			<tiles:insertAttribute name="header" />
			<!-- tiles:insertAttribute name="topNavigation" /--> 
			<!-- tiles:insertAttribute name="leftNavigation" / -->
			<tiles:insertAttribute name="bodyContent" />
			<!-- tiles:insertAttribute name="rightNavigation" /-->
			<tiles:insertAttribute name="footer" />
		</div>
	</body>
</html>
