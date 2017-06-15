<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
	<c:when test="${empty shoppingCart.items}">
		<p>Your cart is empty.</p>
		<div><a href="${flowExecutionUrl}&_eventId=cancelCheckout">[Shop More..]</a></div>
	</c:when>
	<c:otherwise>
		<table id="saleItemsTable">
			<tr>
				<th>Item</th>
				<th>Unit Price</th>
				<th>Quantity</th>
				<th>Total</th>
				<th style="border: none;background: none;"></th>
			</tr>
			<tbody>
			<c:forEach var="item" items="${shoppingCart.items}">
				<tr>
					<td>${item.saleItem.displayName}</td>
					<td>${item.unitCurrencyPrice}</td>
					<td><input type="number" id="itemCount_${item.saleItem.saleItem.id}" name="itemCount_${item.saleItem.saleItem.id}" style="width: 30px;height: 20px;" value="${item.quantity}" /></td>
					<td>${item.totalCurrencyPrice}</td>
					<td style="border: none;background: none;"><input  type="button" value="Update" class="button addcart_button" onclick="javascript:addToCart('${item.saleItem.saleItem.id}')" /></td>
				</tr>
			</c:forEach>
			</tbody>
			<tfoot>
			<tr>
				<td colspan="3" style="text-align: center;font-weight: bolder;">TOTAL</td>
				<td style="font-weight: bolder;">${shoppingCart.totalCurrencyPrice}</td>
				<td style="border: none;background: none;"><a href="${flowExecutionUrl}&_eventId=cancelCheckout"><input  type="button" value="Shop More" class="button addcart_button" /></a></td>
			</tr>
			</tfoot>
		</table>
		
			
	</c:otherwise>
</c:choose>
