<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		$("#highlight-subcategorymenu").addClass("ui-state-focus");
		$("#subCategoryTable").styleTable();
		$("#subCategoryTable").css("font-size", "11px");
	});
</script>
</head>
<body>
<div id="mainLeft"><c:if
	test="${not empty shoppingCart.saleItemCategoryHierarchyList[2]}">
	<table id="subCategoryTable"
		style="margin-left: 10px; margin-top: 10px;">

		<c:forEach items="${shoppingCart.saleItemCategoryHierarchyList[2]}"
			var="cat">
			<tr>
				<td><c:choose>
					<c:when test="${cat.selected eq true}">
						<a href="${contextPath}/shop?id=${cat.id}" id="highlight-subcategorymenu">
					</c:when>
					<c:otherwise>
						<a href="${contextPath}/shop?id=${cat.id}">
					</c:otherwise>
				</c:choose> ${cat.category.name} </a></td>
			</tr>
		</c:forEach>

	</table>
</c:if></div>
</body>
</html>