<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="noOfCategories" value="${fn:length(shoppingCart.saleItemCategoryHierarchyList[1])}"/>
<c:choose>
	<c:when test="${noOfCategories mod 2 eq 0}">
		<c:set var="noOfColumns" value="${noOfCategories / 2}"></c:set>
	</c:when>
	<c:otherwise>
		<c:set var="noOfColumns" value="${(noOfCategories+1) / 2}"></c:set>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
		$(document).ready(function() {
			$("#highlight-submenu").addClass("ui-state-focus");
			$("#mainCategory").html($("#highlight").html());
			$("#categoryTable").styleTable();
			$("#categoryTable").css("font-size","11px");
		});
</script>

<div id="mainHeaderLinks">
				<div id="mainCategory" class="ui-button-text" style="width: 9em;float: left;text-align: center;padding-top: 20px; "></div>
				<div style="width: 90%;margin-left: 9em;">
				<table id="categoryTable">
				<c:forEach items="${shoppingCart.saleItemCategoryHierarchyList[1]}" var="bredcrumb" varStatus="count" >
					<c:if test="${count.index eq 0}">
					<tr>
					</c:if>
					<td>
					<c:choose>
					<c:when test="${bredcrumb.selected eq true}">
					<a href="${contextPath}/shop?id=${bredcrumb.id}" id="highlight-submenu"><span>${bredcrumb.category.name}</span></a>
					</c:when>
					<c:otherwise>
					<a href="${contextPath}/shop?id=${bredcrumb.id}"><span>${bredcrumb.category.name}</span></a>
					</c:otherwise>
					</c:choose>
					</td>
					<c:if test="${noOfColumns eq (count.index+1)}">
					</tr>
					<tr>
					</c:if>
					
					    
				</c:forEach>
				</tr>
				</table>	
				</div>
	
</div>