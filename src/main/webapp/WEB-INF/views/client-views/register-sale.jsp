<%--
  Created by IntelliJ IDEA.
  User: longoc
  Date: 18/01/2018
  Time: 23:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<jsp:include page="../common/head.jsp"/>
<body>
<jsp:include page="../common/menu.jsp"/>
<div id="mainBody">
    <div class="container">
        <div class="row">
            <jsp:include page="../common/sitebar.jsp"/>
            <div class="span9">
                <ul class="breadcrumb">
                    <li><a href="home.html"><s:message code="productDetail.Home"/>/</a> <span class="divider">/</span>
                    </li>
                    <li class="active"><s:message code="register.register"/></li>
                </ul>
                <c:if test="${registerSucceed==true}">
                    <h4><s:message code="register.registerSucceed"/></h4>
                </c:if>
                <h3 style="text-align: center"><s:message code="register.registration"/></h3>
                <div class="well">
                    <div id="check-email">
                        <input type="hidden" id="emailUsed" value="${emailUsed}">
                    </div>
                    <form:form class="form-horizontal" action="register.html" id="register-form" method="post"
                               modelAttribute="customer" cssStyle="margin-left: 20%;">
                        <div class="control-group">
                            <label class="control-label"><s:message code="register.fullname"/><sup>*</sup></label>
                            <div class="controls">
                                <form:input path="name" class="form-control" id="name" placeholder="Your Name"/>
                                <div class="error" id="error_name"><s:message code="register.error.name"/></div>
                            </div>
                            <br>
                            <div class="control-group">
                                <label class="control-label"><s:message
                                        code="register.dateOfBirth"/><sup>*</sup></label>
                                <div class="controls">
                                    <input type="text" path="dateOfBirth" class="form-control" id="datepicker"
                                           placeholder="Your Birthday">
                                    <div class="error" id="error_DOB"><s:message
                                            code="register.error.dateOfBirth"/></div>
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><s:message code="register.gender"/> <sup>*</sup></label>
                            <div class="controls">
                                <form:radiobutton path="gender" checked="checked" value="true"/>      <s:message code="register.male"/>
                                <form:radiobutton path="gender" value="true"/>       <s:message code="register.female"/>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label">Email<sup>*</sup></label>
                            <div class="controls">
                                <form:input path="email" id="email" placeholder="Email"/>
                                <div class="error" id="error_email"><s:message code="register.error.email"/></div>
                                <c:if test="${emailUsed == true}">
                                    <div style="color: red;" id="error_emailUsed"><s:message code="register.error.emailUsed" /></div>
                                </c:if>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label"><s:message code="register.password"/><sup>*</sup></label>
                            <div class="controls">
                                <input name="password" type="password" id="register_password" placeholder="Password">
                                <div class="error" id="error_password"><s:message code="register.error.password"/></div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="address"><s:message code="register.address"/><sup>*</sup></label>
                            <div class="controls">
                                <form:input path="address" id="address" placeholder="Address"/>
                                <div class="error" id="error_address"><s:message code="register.error.address"/></div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="mobile"><s:message code="register.mobilephone"/></label>
                            <div class="controls">
                                <form:input path="phone" name="mobile" id="phone" placeholder="Mobile Phone"/>
                                <div class="error" id="error_phone"><s:message code="register.error.phone"/></div>
                            </div>
                        </div>

                        <p style="color:red;"><sup>*</sup><s:message code="register.requiredFields"/></p>

                        <div class="control-group">
                            <div class="controls">
                                <button class="btn btn-large btn-success" type="submit"><s:message
                                        code="register.title"/></button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>
<script src="resources/js/register.js"></script>
</body>
</html>
