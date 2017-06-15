<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<script type="text/javascript">
		$(document).ready(function(){
			$("#changeBtn").click(function(){
				var url='initStartingSetup';
				$(location).attr('href',url);
			});
		});
</script>
<div id="mainRight">

<div class="ui-widget-content ui-corner-all">
<c:forEach items="${shoppingCart.startupHierarchyList}" var="bredcrumb" >
<label>${bredcrumb.category.name}</label>-->
</c:forEach>
<c:if test="${not empty shoppingCart.startupHierarchyList and shoppingCart.itemCount == 0}">
<input name="change" id="changeBtn" type="button" value="Change" class="button ui-state-default ui-corner-all ui-button"  />
</c:if>
</div>
<div class="ui-widget-content ui-corner-all">
	Your cart currently contains <span id="itemCount">${shoppingCart.itemCount}</span> items. Subtotal:<span id="subTotal">${shoppingCart.totalCurrencyPrice}</span> 
						<c:if test="${shoppingCart.itemCount>0}"><a href="${contextPath}/eShop/checkout.do">Checkout &raquo;</a></c:if>
	
	</div>
</div>