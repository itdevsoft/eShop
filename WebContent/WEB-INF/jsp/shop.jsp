<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html>
	<head>
		<title>Sale Items</title>
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
			if ( bValid && qty>0) {
				
			var url='<c:out value="${contextPath}" />/addToCart.do?saleItemId='+itemId+'&quantity='+qty; 

			var request = $.ajax({
				  type: "GET",
				  url: url,
				  dataType: "json"
				});
			request.done(function(jd) {
				$("#changeBtn").css('visibility','hidden');
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
				
		<div style="margin-top: 25px;min-height: 25em;">
			<div>
				<div>
					<c:set value="false" var="isEmpty" />
					<c:if test="${not empty saleItemCategories}">
					<c:set value="true" var="isEmpty" />
					<ol id="itemBox">
	
						<c:forEach items="${saleItemCategories}" var="cat" >
							<a href="${contextPath}/shop?id=${cat.id}"><li class="ui-state-default" style="background:transparent url('/eSaleImages/Category_${cat.category.id}.${cat.category.imageExt}') no-repeat scroll 0 30%;width:160px;height:160px;border:none"><span style="margin-left: -70px;margin-top: 150px;position: absolute;">${cat.category.name}</span></li></a>
						</c:forEach>
						
					</ol>
					</c:if>	
					<c:if test="${not empty saleItems}">
					<c:set value="true" var="isEmpty" />
					<ol id="itemBox">
					<c:forEach var="saleItem" items="${saleItems}">
					<li class="ui-state-default ui-corner-all" style="background:transparent url('/eSaleImages/${saleItem.saleItem.id}.${saleItem.saleItem.imageExt}') no-repeat scroll 0 50%;">
					<div style="text-align:right;padding: 10px 10px;height: 60px;">
					${saleItem.saleItem.name}<br/>
					${saleItem.description}<br/>
					${saleItem.price} ${saleItem.saleItem.priceFor}
					</div>
					<div style="margin-top: 80px;">
					<input type="number" maxlength="2" value="1" id="itemCount_${saleItem.saleItem.id}" name="itemCount_${saleItem.saleItem.id}" style="width: 30px;height: 20px;padding: 5px 5px;display: inline;margin-right: 5px;margin-bottom: 2px" />
					<input  type="button" value="Add to cart" class="button addcart_button ui-state-default ui-corner-all ui-button" onclick="javascript:addToCart('${saleItem.saleItem.id}')" />
					</div>
					
					</li>
					</c:forEach>
					</ol>
					</c:if>
					<c:if test="${not isEmpty}">
					<h4 style="text-align: center;">No Items in stock</h4>
					</c:if>
					
				</div>
			</div>
			<!--
			<div class="yui-b">
				<h2>Satisfaction Guaranteed</h2>
				<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec mattis metus sed est. Pellentesque facilisis facilisis dolor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent in libero at leo porta hendrerit.</p>
				
				<h2>Return Policy</h2>
				<p>Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec dignissim, risus ac convallis accumsan, felis leo feugiat purus, tempor blandit nunc ante vel dui. Nullam ut turpis id magna hendrerit tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>
			</div>
			-->
		</div>
		<div id="dialog-message" title="Information" style="display: none;">
			<div id="dialog-message-text" class="validateTips" style="font-size: 11px;font-weight: bold;"></div>
		</div>
	</body>
</html>
