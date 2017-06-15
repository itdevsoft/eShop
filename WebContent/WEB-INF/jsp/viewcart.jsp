<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html>
	<head> 
		<title>Checkout</title>
		<script type="text/javascript">
		$(document).ready(function () {
			$("#saleItemsTable").styleTable();

			$( "#dialog-message" ).dialog({
	    		autoOpen: false,
	    		height: 200,
	    		width: 350,
	    		modal: true,
	    		title: 'Information Message',
	    		buttons: {
	        	" Ok ": function() {
					$( this ).dialog( "close" );
					$(location).attr('href','<c:out value="${contextPath}" />/checkout.do');
				}
				}
			});
		});
		function addToCart(itemId){
			var bValid = true;
			var qty = $("#itemCount_"+itemId).val();
				bValid = bValid && checkLength($("#itemCount_"+itemId),$( ".validateTips" ),"Item count", 1, 3 );
				bValid = bValid && checkRegexp( $("#itemCount_"+itemId),$( ".validateTips" ), /^([0-9])+$/i, "Item count may consist of 0-9." );
				bValid = bValid && checkValue($("#itemCount_"+itemId),$( ".validateTips" ),"Item count", 0, 100 );
			if ( bValid) {
				
			var url='<c:out value="${contextPath}" />/addToCart.do?saleItemId='+itemId+'&quantity='+qty; 
		
		
			var request = $.ajax({
				  type: "GET",
				  url: url,
				  dataType: "json"
				});
			request.done(function(jd) {
				$("#itemCount").html(jd.item_count);
				$("#subTotal").html(jd.total_price);
				$("#dialog-message-text").html(jd.message);
				$("#dialog-message").show();
				$("#dialog-message" ).dialog( "open" );
				
			});
		
			request.fail(function(jqXHR, textStatus) {
				$("#dialog-message-text").html(textStatus);
				$("#dialog-message").show();
				$("#dialog-message" ).dialog( "open" );
			});
		
			}else{
				updateTips($( ".validateTips" ), "Invalid quantity.");
				$("#dialog-message").show();
				$("#dialog-message" ).dialog( "open" );
			}
		}
</script>
	</head>
	<body>
		<c:if test="${not empty message}"><jsp:include page="messagedisplay.jsp" /></c:if>
		
		<div style="margin-top: 35px;">
			<div class="page-title">
				<div></div>
				<div style="clear:both"></div>
			</div>
			<div>
				<div>
					<h5>${shoppingCart.itemCount} item in your shopping cart (Total Amount  ${shoppingCart.totalCurrencyPrice})  -  <a href="${flowExecutionUrl}&_eventId=cancelCheckout">shop more</a></h5>
					<jsp:include page="carttable.jsp"/>
				</div>
			</div>
			<c:if test="${shoppingCart.itemCount>0}">
			<c:choose>
			<c:when test="${shoppingCart.customer != null and shoppingCart.customer.id>0}">
			<h4 style="margin-top: 30px;"><a href="${flowExecutionUrl}&_eventId=paymentAndShipping">Shipping and Payment Options</a></h4>
			</c:when>
			<c:otherwise>
			<div>
				<h5>New or Returning Customer?</h5>
				
				<h6>New customers, please
				<a href="${flowExecutionUrl}&_eventId=register">register</a>.</h6>
				
				<h6>Returning customers, please 
				<a href="${flowExecutionUrl}&_eventId=login">log in</a>.</h6>
				
				<h5>Do not want to register now...<a href="${flowExecutionUrl}&_eventId=paymentAndShipping">Express checkout</a></h5>
			</div>
			</c:otherwise>
			</c:choose>
			</c:if>
		</div> 
		<div id="dialog-message" title="Information" style="display: none;">
			<div id="dialog-message-text" class="validateTips" style="font-size: 11px;font-weight: bold;"></div>
		</div>
	</body>
</html>
