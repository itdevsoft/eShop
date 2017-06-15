<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

  <!--header wrapper -->

  <header class="row-fluid header_wrap">
    <div class="span4"><a href="#" class="logo" >eShop</a></div>
    <div class="span6 pull-right">
       <div class="span6 contacts pull-right">
      </div>
    </div>
  </header>

  <!--header wrapper end -->

  <!--main menu -->

  <nav class="navbar">
    <ul class="nav">
    	<c:choose>
					<c:when test="${shoppingCart.startupHierarchyList == null or empty shoppingCart.startupHierarchyList}">
					<li class="active"><a href="${contextPath}/initStartingSetup">Home</a></li>
					</c:when>
					<c:otherwise>
					<li class="active"><a href="${contextPath}/shop?id=0">Home</a></li>
					</c:otherwise>
	    </c:choose>
      
      <li class="dropdown"><a href="${contextPath}/checkout.do" >View Cart</a></li>
      <li ><a href="${contextPath}/checkout.do">Checkout</a></li>
      <li class="dropdown"><a href="${contextPath}/checkout.do" >Delivery Info</a></li>
    </ul>
  </nav>

  <!--main menu end -->
  <div class="clearfix"></div>
 