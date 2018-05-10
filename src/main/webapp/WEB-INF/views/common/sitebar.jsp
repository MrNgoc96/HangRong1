
<%--
  Created by IntelliJ IDEA.
  User: longoc
  Date: 18/01/2018
  Time: 23:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<c:set var="cartBean" value="${sessionScope.cartBean}"/>
<c:set var="quantity" value="0"/>
<c:set var="totalPrice" value="0"/>
<c:forEach items="${cartBean}" var="item">
    <c:set var="quantity" value="${quantity = quantity + item.value.quantity}"></c:set>
    <c:set var="totalPrice" value="${totalPrice = totalPrice + (item.value.product.newPrice * item.value.quantity)}"></c:set>
</c:forEach>
<div id="sidebar" class="span3">
    <div class="well well-small" id="cartBean">
        <a id="myCart" href="/cart">
            <img src="resources/images/ico-cart.png" alt="cart">${quantity} <s:message code="home.itemesInYourCart" />
            <span class="badge badge-warning pull-right">$${totalPrice}</span>
        </a>
    </div>
    <ul id="sideMemu" class="nav nav-tabs nav-stacked">
        <li class="subMenu open">
            <a href="products.html?categoryId=TBDT"><s:message code="home.electronics" /></a>
        </li>
        <li class="subMenu">
            <a href="products.html?categoryId=TT"><s:message code="home.fashion" />  </a>
        </li>
        <li class="subMenu">
            <a href="products.html?categoryId=DGDS"><s:message code="home.supermarketsAndGroceryStores" /></a>
        </li>
        <li>
            <a href="products.html?categoryId=TTDL"><s:message code="home.sportAndTourism" /></a>
        </li>
        <li>
            <a href="products.html?categoryId=SGT"><s:message code="home.bookAndEntertainment" /></a>
        </li>
    </ul>
    <br/>
    <c:forEach items="${featureProducts}" var="product" begin="6" end="7">
    <div class="thumbnail">
        <a href="products.html?productId=${product.id}">
            <img src="${product.image[0]}" alt=""/>
        </a>
        <div class="caption">
            <h5>${product.name}</h5>
            <h4 style="text-align:center">
                <a class="btn" href="products.html?productId=${product.id}">
                    <i class="fa fa-search-plus"></i>
                </a>
                <a class="btn" href="#"><s:message code="home.addTo" />
                    <i class="fa fa-shopping-cart"></i>
                </a>
                <a class="btn btn-primary" href="#">$${product.newPrice}</a>
            </h4>
        </div>
    </div>
    <br/>
    </c:forEach>
    <div class="thumbnail">
        <img src="resources/images/payment_methods.png" title="Bootshop Payment Methods" alt="Payments Methods">
        <div class="caption">
            <h5><s:message code="home.PaymentMethods" /></h5>
        </div>
    </div>
</div>
</body>
</html>
