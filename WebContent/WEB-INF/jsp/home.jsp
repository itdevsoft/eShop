<%@ page isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:forEach items="${systemHierarchySetupList}" var="hierarchyType" >
<c:if test="${hierarchyType.value eq startupHierarchyHome}">
<c:set var="startupHierarchyKey" value="${hierarchyType.key}" />
</c:if>
</c:forEach>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<%@page import="java.util.List"%>
<%@page import="com.eservice.core.beans.NestedCategory"%><html>
	<head>
		<title>Home</title>
		<script type="text/javascript">
		$(document).ready(function () {
			changeSelectBoxVal('${startupHierarchyHome}','${startupHierarchyKey}');
			
		});
		function changeSelectBoxVal(selectBoxId,value){
			var url = '<c:out value="${contextPath}" />/getStartingSetup?type='+selectBoxId+'&id='+value; 
			$.getJSON(url, function(jd) {
				<c:forEach items="${startupCriteriaList}" var="startCat">
					var deliveryLocationArr = jd.${startCat};
					if(deliveryLocationArr!=null && deliveryLocationArr.length>0){
						$("#${startCat}Div").html('');
		             	$("#${startCat}Div").append('<select id="${startCat}" name="${startCat}"  onchange="changeSelectBoxVal(this.id,this.value)"></select>');
		             	$.each(deliveryLocationArr, function(i, obj) { 
			            	 $.each(obj, function(key, value) {
			            		 $("#${startCat}").append($('<option></option>').val(key).html(value)); 
			            	 });
			            });
					}else if(deliveryLocationArr==''){
						$("#${startCat}Div").html('');
					}
	            </c:forEach>
					
	             
	                   
	          });
			
		}
		</script>
	</head>
	<body>
		<div class="linebreak-25"></div>
		<div>
		<form action="setStartingSetup" id="startupForm" method="post">
		<fieldset>
		<label>Please select the delivery criteria to display the sale item catalogue</label><br/>
		<label>Deliver To : </label>
		<c:forEach items="${startupCriteriaList}" var="startCat">
		<div id="${startCat}Div" style="display: inline;">
			<select name="${startCat}" id="${startCat}" onchange="changeSelectBoxVal(this.id,this.value)">
				<c:forEach items="${startList[startCat]}" var="cat">
				<option value="${cat.id}" label="${cat.category.name}">${cat.category.name}</option>
				</c:forEach>
			</select>
		
		</div>
		</c:forEach>
		
		<input name="submit" type="submit" value="Go to sale items" class="button ui-state-default ui-corner-all ui-button" />
		</fieldset>
		</form>
		</div>
		<div class="linebreak-25"></div>
	</body>
</html>
