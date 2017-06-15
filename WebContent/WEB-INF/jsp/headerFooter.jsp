<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<div id="headerFooter">
				<nav class="navbar">
	    			<ul class="nav" style="left: -190px;margin-top: -25px;">
				<c:forEach items="${shoppingCart.saleItemCategoryHierarchyList[0]}" var="bredcrumb" >
					<c:choose>
					<c:when test="${bredcrumb.selected eq true}">
					<li class="active"><a href="${contextPath}/shop?id=${bredcrumb.id}">${bredcrumb.category.name}</a></li>
					</c:when>
					<c:otherwise>
					<li class="dropdown"><a href="${contextPath}/shop?id=${bredcrumb.id}" >${bredcrumb.category.name}</a></li>
					</c:otherwise>
					</c:choose>
				</c:forEach>	
				</ul>
  				</nav>
				
	
</div>