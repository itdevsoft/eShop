<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:forEach items="${systemHierarchySetupList}" var="hierarchyType" >
<c:if test="${hierarchyType.value eq startupHierarchySchedule}">
<c:set var="startupHierarchyKey" value="${hierarchyType.key}" />
</c:if> 
<c:if test="${hierarchyType.value eq startupHierarchyShippingMethod}">
<c:set var="startupHierarchyMethodKey" value="${hierarchyType.key}" />
</c:if> 
</c:forEach>
	<head>
		<title>Shipping and Payment Options</title>
		<script type="text/javascript">
		$(document).ready(function () { 
			changeSelectBoxValForSchedule('${startupHierarchySchedule}','${startupHierarchyKey}');
			changeSelectBoxValForMethod('${startupHierarchyShippingMethod}','${startupHierarchyMethodKey}');
		});
		function changeSelectBoxValForSchedule(selectBoxId,value){
			var url = '<c:out value="${contextPath}" />/getStartingSetup?type='+selectBoxId+'&id='+value; 
			$.getJSON(url, function(jd) {
				<c:forEach items="${shippingScheduleCriteriaList}" var="startCat">
					var scheduleArr = jd.${startCat};
					if(scheduleArr!=null && scheduleArr.length>0){
						$("#${startCat}Div").html('');
		             	$("#${startCat}Div").append('<select id="${startCat}" name="${startCat}"  onchange="changeSelectBoxValForSchedule(this.id,this.value)"></select>');
		             	$.each(scheduleArr, function(i, obj) { 
			            	 $.each(obj, function(key, value) {
			            		 $("#${startCat}").append($('<option></option>').val(key).html(value)); 
			            	 });
			            });
					}else if(scheduleArr==''){
						$("#${startCat}Div").html('');
					}
	            </c:forEach>
					
	             
	                   
	          });
		}
		function changeSelectBoxValForMethod(selectBoxId,value){
			var url = '<c:out value="${contextPath}" />/getStartingSetup?type='+selectBoxId+'&id='+value; 
			$.getJSON(url, function(jd) {
				<c:forEach items="${shippingMethodCriteriaList}" var="startCat">
					var scheduleArr = jd.${startCat};
					if(scheduleArr!=null && scheduleArr.length>0){
						$("#${startCat}Div").html('');
		             	$("#${startCat}Div").append('<select id="${startCat}" name="${startCat}"  onchange="changeSelectBoxValForMethod(this.id,this.value)"></select>');
		             	$.each(scheduleArr, function(i, obj) { 
			            	 $.each(obj, function(key, value) {
			            		 $("#${startCat}").append($('<option></option>').val(key).html(value)); 
			            	 });
			            });
					}else if(scheduleArr==''){
						$("#${startCat}Div").html('');
					}
	            </c:forEach>
					
	             
	                   
	          });
		}
    function doPay(payAmount){
    	payAmount =payAmount.replace('$','');
    	alert(payAmount);
        var url = 'https://api-3t.sandbox.paypal.com/nvp';
        var user = 'eshop_1332911551_biz_api1.yahoo.com';
        var password='1332911572';
        var signature = 'AQuC3M5jX2di13bDxAQ7EhtdzbjAAim2BvoQitBESHjKLcoJXFAlBLYL';
        var version = 52.0;
        var paymentaction = 'Sale';
        var returnurl = 'http://localhost:8080/eShop/initStartingSetup';
        var method = 'SetExpressCheckout';
    	var request = $.ajax({
			  type: "POST",
			  url: url,
			  data:{USER : user,PWD : password,SIGNATURE : signature,VERSION:version,PAYMENTACTION:paymentaction,AMT:payAmount,RETURNURL:returnurl,CANCELURL:returnurl,METHOD:method},
			  dataType: "text"
			});
		request.done(function(msg) {
			alert(msg);
			
		});

		request.fail(function(jqXHR, textStatus) {
			alert(jqXHR.status);
			//alert(textStatus);
		});
    }
        </script>
	</head>
	<body>
		<c:if test="${not empty message}"><jsp:include page="messagedisplay.jsp" /></c:if>
		
		<div id="bd" style="margin-top: 30px;">
			<div class="page-title">
			<h5>${shoppingCart.itemCount} item in your shopping cart (Total Amount  ${shoppingCart.totalCurrencyPrice}) - Complete Your Checkout or  <a href="${flowExecutionUrl}&_eventId=cancelCheckout">shop more</a></h5>
				<div style="clear:both"></div>
			</div>
			<form action="setStartingSetup" id="startupForm" method="post">
		
			<div>
					<div>
						<h5 style="margin-top:0">Shipping Information</h5>
						<!-- <div style="margin:20px 0">
							Shipping Method:
							<select>
								<c:forEach var="option" items="${shippingOptions}">
									<option>${option}</option>
								</c:forEach>
							</select>
						</div> -->
						
						<div style="margin:20px 0">
							Shipping Method:
							<c:forEach items="${shippingMethodCriteriaList}" var="startCat">
		<div id="${startCat}Div" style="display: inline;">
			<select name="${startCat}" id="${startCat}" onchange="changeSelectBoxValForMethod(this.id,this.value)">
				<c:forEach items="${startList[startCat]}" var="cat">
				<option value="${cat.id}" label="${cat.category.name}">${cat.category.name}</option>
				</c:forEach>
			</select>
		
		</div>
		</c:forEach>
							
							
						</div>
						
						<div style="margin:20px 0">
							Shipping Schedule:
							<c:forEach items="${shippingScheduleCriteriaList}" var="startCat">
		<div id="${startCat}Div" style="display: inline;">
			<select name="${startCat}" id="${startCat}" onchange="changeSelectBoxValForSchedule(this.id,this.value)">
				<c:forEach items="${startList[startCat]}" var="cat">
				<option value="${cat.id}" label="${cat.category.name}">${cat.category.name}</option>
				</c:forEach>
			</select>
		
		</div>
		</c:forEach>
							
							
						</div>
						<div>
							<h5>Where would you like us to ship your order?</h5>
							<fieldset>
								<label>Given Name/s :</label>
									<input type="text" name="otherNames" value="${shoppingCart.customer.otherNames}" />
								<br/>
								<label>Family Name :</label>
									<input type="text" name="lastName" value="${shoppingCart.customer.lastName}" />
								<br/>
								<label>Address 1:</label>
									<input type="text" name="address1" value="${shoppingCart.customer.locationContactDetailList[0].addressLine1}" />
								<br/>
								<label>Address 2:</label>
									<input type="text" name="address2" value="${shoppingCart.customer.locationContactDetailList[0].addressLine2}" />
								<br/>
								<label>City:</label>
									<input type="text" name="city" value="${shoppingCart.customer.locationContactDetailList[0].city}" />
								<br/>
								<label>State:</label>
									<input type="text" name="state" value="${shoppingCart.customer.locationContactDetailList[0].stateCode}" />
								<br/>
								<label>Post Code:</label>
									<input type="text" name="zipCode" value="${shoppingCart.customer.locationContactDetailList[0].postCode}" />
								<br/>
								<br/>
								<input id=payAmount value=${shoppingCart.totalCurrencyPrice} readonly="readonly"><a href="${flowExecutionUrl}&_eventId=payOrder"><input  type="button" value="Pay Now" class="button addcart_button" style="margin-left: 10px;" /></a>
								
							</fieldset>
						</div>
					</div>
					
				</div>
				</form>
				<%-- This triggers a submit event --%>
				<div style="text-align:center">
					<a href="${flowExecutionUrl}&_eventId=cancelCheckout"><input  type="button" value="Shop More" class="button addcart_button"  /></a>
					<a href="${flowExecutionUrl}&_eventId=back"><input  type="button" value="back to cart" class="button addcart_button"  /></a>
				</div>
			
		</div>
		<div>
						
						
		</div>
		
		<div id="dialog-message" title="Information" style="display: none;">
<div id="dialog-message-text" style="font-size: 11px;font-weight: bold;"></div>
</div>
	</body>
</html>
