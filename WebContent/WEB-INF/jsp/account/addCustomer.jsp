<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html> 
<title>${heading}</title>
<body>
<div style="margin-top: 35px;">
<h3>${heading}</h3>

<c:if test="${not empty message}"><jsp:include page="../messagedisplay.jsp" /></c:if>

<div id="dialog-form" title="Create new user">
<form:form action="${action}" commandName="user">
	
<fieldset title="Personal Details" >
<label class="fieldsetLabel" for="personalDetails">Personal Details</label>
<div class="linebreak-10"></div>
<c:if test="${user.id>0}">
<form:hidden path="id" id="id"  /></div>
</c:if>
<div class="formline"><label for="title">Title</label>
<form:select path="title" cssClass="select ui-widget-content ui-corner-all" items="${titleList}" />

 </div>
<div class="formline"><label for="otherNames">First
Name(s)</label> 
<form:input path="otherNames" id="otherNames" cssClass="text ui-widget-content ui-corner-all" /></div>
<div class="formline"><label for="lastName">Last Name</label> 
<form:input path="lastName" id="lastName" cssClass="text ui-widget-content ui-corner-all" /></div>
<div class="formline"><label for="gender">Gender</label>
<form:radiobutton path="gender" cssClass="radio ui-widget-content ui-corner-all" value="M"/>Male
<form:radiobutton path="gender" cssClass="radio ui-widget-content ui-corner-all" value="F"/>Female
</div>
<div class="formline"><label for="enabled">Activate</label>
<form:checkbox path="enabled" />
</div>
</fieldset>
<fieldset>
<label class="fieldsetLabel" for="contactDetails">Contact Details</label>
<div class="linebreak-10"></div>
<c:if test="${user.locationContactDetailList[0].id>0}">
<input type="hidden" name="locationContactDetailList[0].id" value="${user.locationContactDetailList[0].id}"  />
</c:if>
<input type="hidden" name="locationContactDetailList[0].prioriyLevel" value="${user.locationContactDetailList[0].prioriyLevel}"  />

<div class="formline"><label for="addressLine1">Address Line1</label> 
<form:input path="locationContactDetailList[0].addressLine1" id="addressLine1" cssClass="text ui-widget-content ui-corner-all" /></div>
<div class="formline"><label for="addressLine2">Address Line2</label> 
<form:input path="locationContactDetailList[0].addressLine2" id="addressLine2" cssClass="text ui-widget-content ui-corner-all" /></div>
<div class="formline"><label for="city">City</label> 
<form:input path="locationContactDetailList[0].city" id="city" cssClass="text ui-widget-content ui-corner-all" /></div>
<div class="formline"><label for="stateCode">State</label> 
<form:input path="locationContactDetailList[0].stateCode" id="stateCode" cssClass="text ui-widget-content ui-corner-all" /></div>
<div class="formline"><label for="postCode">Post Code</label> 
<form:input path="locationContactDetailList[0].postCode" id="postCode" cssClass="text ui-widget-content ui-corner-all" /></div>
<div class="formline"><label for="countryCode">Country</label> 
<form:input path="locationContactDetailList[0].countryCode" id="countryCode" cssClass="text ui-widget-content ui-corner-all" /></div>
<div class="linebreak-10"></div>
<c:forEach items="${user.voiceContactDetailList}" var="voiceContact" varStatus="count" >
<div class="formline"><label for="voiceContactType">${voiceContact.voiceContactType} Number</label>
<c:if test="${voiceContact.id>0}">
<input type="hidden" name="voiceContactDetailList[${count.index}].id" value="${voiceContact.id}"  />
</c:if>
<input type="hidden" name="voiceContactDetailList[${count.index}].voiceContactType" value="${voiceContact.voiceContactType}"  />
<input type="hidden" name="voiceContactDetailList[${count.index}].priorityLevel" value="${voiceContact.priorityLevel}"  />
<form:input path="voiceContactDetailList[${count.index}].contactNumber" cssClass="text ui-widget-content ui-corner-all" />
</div> 
</c:forEach>
<div class="formline"><label for="email">Email Address</label> 
<form:input path="email" id="email" cssClass="text ui-widget-content ui-corner-all" />
</div>
</fieldset>
<fieldset>
<label class="fieldsetLabel" for="loginDetails">Login Details</label>
<div class="linebreak-10"></div>
<div class="formline"><label for="userName">User Name</label> 
<form:input path="userName" id="userName" cssClass="text ui-widget-content ui-corner-all" />
</div>
<div class="formline"><label for="password">Password</label> 
<form:password path="password" id="password" cssClass="text ui-widget-content ui-corner-all" /></div>
</fieldset>
<fieldset>
<div class="formline"><input name="submit" type="submit"
	value="${buttonLabel}" class="button ui-state-default ui-corner-all ui-button" />

</fieldset>
</form:form>

</div>
</body>
</html>