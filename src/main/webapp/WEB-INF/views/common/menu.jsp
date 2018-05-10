<%--
  Created by IntelliJ IDEA.
  User: longoc
  Date: 18/01/2018
  Time: 23:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Hàng Rong</title>
</head>
<body>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<input type="hidden" value="${sessionScope.googleLogin==null?'false':sessionScope.googleLogin}" id="googleLogin">
<script>
    var googleLogin =  $('#googleLogin').val()
</script>
<div id="header">

    <div class="container" style="width: 100%" ;>
        <c:set var="cartBean" value="${sessionScope.cartBean}"/>
        <c:set var="quantity" value="0"/>
        <c:forEach items="${cartBean}" var="item">
            <c:set var="quantity" value="${quantity = quantity + item.value.quantity}"></c:set>
        </c:forEach>

        <!-- Navbar ================================================== -->
        <div id="logoArea" class="navbar">
            <a id="smallScreen" data-target="#topMenu" data-toggle="collapse" class="btn btn-navbar">
                <span class="fa fa-bar"></span>
                <span class="fa fa-bar"></span>
                <span class="fa fa-bar"></span>
            </a>
            <div class="navbar-inner">
                <a class="brand" href="home.html" style="width: 15%;color: white">
                    <img class="img-rounded" src="resources/images/logo.png" alt="Bootsshop" width="25%"/>
                    Hàng Rong
                </a>
                <form class="form-inline navbar-search" method="get" action="search-product.html" style="margin-top: 10px;">
                    <input name="key" type="text" style="height: 30px;"/>
                    <select name="categoryId" style="width: 200px" id="categories" >
                        <option value="All"><s:message code="home.all"/></option>
                        <option value="TT"><s:message code="home.fashion"/></option>
                        <option value="DGDS"><s:message code="home.supermarketsAndGroceryStores"/></option>
                        <option value="TBDT"><s:message code="home.electronics"/></option>
                        <option value="TTDL"><s:message code="home.sportAndTourism"/></option>
                        <option value="SGT"><s:message code="home.bookAndEntertainment"/></option>
                    </select>
                    <button type="submit" id="submitButton" class="btn btn-primary"><s:message
                            code="home.search"/></button>
                </form>
                <ul id="topMenu" class="nav pull-right" style="width: 48%">
                    <li>
                        <a href="#"><s:message code="home.sale"/></a>
                    </li>
                    <li>
                        <a href="register-sale.html"><s:message code="home.registeredSales"/></a>
                    </li>
                    <li>
                        <a href="#"><s:message code="home.changeLanguage"/></a>
                        <c:set var="queryString" value="${pageContext.request.queryString}"></c:set>
                        <ul class="sub-menu1">
                            <li>
                                <a href="?${fn:contains(queryString,'&lang') ? fn:substringBefore(queryString, '&lang') : queryString }&lang=vi">VN / VIETNAM
                                    <img src="resources/images/15_46_1314924450_93_vnm_2011_377844.jpg"
                                         style="width:30px; height:20px;"
                                    />
                                </a>
                            </li>
                            <li>
                                <a href="?${fn:contains(queryString,'&lang') ? fn:substringBefore(queryString, '&lang') : queryString }&lang=en">EN / ENGLISH
                                    <img src="resources/images/images.png" style="width:30px; height:20px;"/>
                                </a>
                            </li>
                        </ul>
                    </li>
                    <li style="width: 19%">
                        <a href="view-cart.html"><img
                                src="http://icons.iconarchive.com/icons/graphicloads/100-flat/256/cart-icon.png"
                                width="55%"><span class="badge">${quantity}</span></a>
                    </li>
                    <c:if test="${sessionScope.currentUser == null}">
                        <a href="#login" role="button" data-toggle="modal">
                        <span class="btn btn-large btn-success" style="margin-top: 2%;"><s:message
                                code="home.login"/></span>
                        </a>
                    </c:if>
                    <c:if test="${sessionScope.currentUser != null}">
                        <div id="customer-action">
                            <a><img src="https://2lvyko39307c3lxh9sd6iu2e-wpengine.netdna-ssl.com/wp-content/uploads/2014/07/grow-loyalty-icon-800x800.png"
                                 width="50%" class="img-circle" style="margin-top: 10%;border: white"></a>
                                <ul id="submenu">
                                    <li><a href="personal-information.html"><i class="fa fa-user-circle"></i> ${sessionScope.currentUser.name}</a>
                                    </li>
                                    <li><a href="orders.html"><i class="fa fa-id-card"></i> <s:message code="home.yourOrder"/> </a></li>
                                    <li><a href="${sessionScope.googleLogin==true?'#':'log-out.html'}"  onclick="${sessionScope.googleLogin==true?'signOut()':''}"><i class="fa fa-sign-out"></i> <s:message code="home.logout"/> </a>
                                    </li>
                                </ul>
                        </div>
                    </c:if>
                    <div id="login" class="modal hide fade in" tabindex="-1" role="dialog" aria-labelledby="login"
                         aria-hidden="false">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            <h3><s:message code="home.login"/></h3>
                        </div>
                        <div class="modal-body" id="form-login">
                            <script src="https://apis.google.com/js/platform.js" async defer></script>
                            <input type="hidden" id="login_error" value="${message}">
                            <h5 style="color:red;display: none;" id="loginMessage"><s:message code="home.loginFail" /> </h5>
                            <h5 style="color:red;display: none;" id="googleLoginMessage"> <s:message arguments="${message}" code="home.googleLoginFail" /> </h5>
                            <img src="resources/images/please_wait.gif"  id="loading" width="50%" style="display: none;">
                            <form class="form-horizontal loginFrm" action="login.html" method="post" id="login-form">
                                <div class="control-group">
                                    <h6 id="username_error" style="display: none;color: red"><s:message code="home.error-username" /></h6>
                                    <input type="text" id="username" style="height: 30px;margin-bottom: 10px;"
                                           name="username" placeholder="<s:message code="home.username" />">
                                </div>
                                <div class="control-group">
                                    <h6 id="password_error" style="display: none;color: red"><s:message code="home.error-password" /></h6>
                                    <input type="password" id="password" style="height: 30px;" name="password"
                                           placeholder="<s:message code="home.password" />">
                                </div>

                                <button onclick="login()" type="button" class="btn btn-success" style="width:130px;"><s:message
                                        code="home.login"/></button>
                                <a href="register.html">
                                    <button type="button" class="btn btn-primary" style="width:130px;"><s:message
                                            code="home.register"/></button>
                                </a>
                            </form>
                            <div style="margin-left: 40%;margin-bottom: 5%;" class="g-signin2"
                                 data-onsuccess="onSignIn"></div>
                        </div>
                    </div>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
