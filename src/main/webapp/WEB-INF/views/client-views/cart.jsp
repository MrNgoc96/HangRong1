<%--
  Created by IntelliJ IDEA.
  User: longoc
  Date: 18/01/2018
  Time: 23:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
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
                    <li><a href="index.html">Home</a> <span class="divider">/</span></li>
                    <li class="active"><s:message code="cart.shoppingCart"/></li>
                </ul>
                <c:set var="cartBean" value="${sessionScope.cartBean}"/>
                <h3><s:message code="cart.cartHasProducts" arguments="${fn:length(cartBean)}"/> <a
                        href="home.html" class="btn btn-large pull-right"><i
                        class="fa fa-arrow-left"></i> <s:message code="cart.continueShoping"/></a></h3>
                <hr class="soft"/>
                <table class="table table-bordered" id="cart">
                    <thead>
                    <tr>
                        <th><s:message code="cart.product"/></th>
                        <th><s:message code="cart.productName"/></th>
                        <th><s:message code="cart.quantityUpdate"/></th>
                        <th><s:message code="cart.price"/></th>
                        <th><s:message code="cart.discount"/></th>
                        <th><s:message code="cart.total"/></th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="totalPrice" value="0"/>
                    <c:forEach items="${cartBean}" var="item">
                        <c:set var="totalPrice"
                               value="${totalPrice = totalPrice + item.value.product.newPrice * item.value.quantity}"/>
                        <tr>
                            <td><img width="60" src="${item.value.product.image[0]}" alt=""/></td>
                            <td>${item.value.product.name}</td>
                            <td>
                                <div class="input-append"><input class="span1"
                                                                 style="max-width:34px;height:24px !important;"
                                                                 value="${item.value.quantity}"
                                                                 id="productQuantity" type="text">
                                    <button class="btn" onclick="decreasedQuantity('${item.value.product.id}')"
                                            type="button"><i class="fa fa-minus"></i></button>
                                    <button class="btn" onclick="increasedQuantity('${item.value.product.id}')"
                                            type="button"><i class="fa fa-plus"></i></button>
                                    <button class="btn btn-danger" onclick="removeProduct('${item.value.product.id}')"
                                            type="button"><i class="fa fa-remove fa fa-white"></i>
                                    </button>
                                </div>
                            </td>
                            <td>$${item.value.product.price}</td>
                            <td><f:formatNumber value="${item.value.product.discount}" type="percent"/></td>
                            <td>$${item.value.product.newPrice * item.value.quantity}</td>
                        </tr>
                    </c:forEach>
                    <tr></tr>
                    <tr>
                        <td style="text-align:right"><strong>TOTAL :</strong></td>
                        <td class="label label-important" style="display:block"><strong>
                            $${totalPrice} </strong></td>
                    </tr>
                    </tbody>
                </table>
                <hr>
                <h3 style="text-align: center"><s:message code="cart.order"/></h3>
                <form action="order.html" method="post" style="margin-left: 40%" id="form-order">
                    <input name="gender"
                           type="radio" ${currentUser.gender=='Nam'||currentUser.gender==null?'checked':''}
                           name="gender" value="Nam"> <s:message code="cart.customer.male"/>
                    <input name="gender" style="margin-left: 10%" type="radio" ${currentUser.gender=='Nữ'?'checked':''}
                           name="gender" value="Nữ"> <s:message code="cart.customer.female"/>
                    <label><s:message code="cart.customerName"/></label>
                    <input type="text" id="orderName" value="${currentUser.name}" name="name">
                    <div class="error" id="error_orderName"><s:message code="cart.error.orderName"/></div>
                    <br>
                    <label>Email</label>
                    <input type="text" id="orderEmail" value="${currentUser.email}" name="email">
                    <div class="error" id="error_orderEmail"><s:message code="cart.error.orderEmail"/></div>
                    <br>
                    <label><s:message code="cart.orderAddress"/></label>
                    <input type="text" id="orderAddress" value="${currentUser.address}" name="address">
                    <div class="error" id="error_orderAddress"><s:message code="cart.error.orderAddress"/></div>
                    <br>
                    <button class="btn btn-large pull-right"><s:message code="cart.order"/> <i
                            class="fa fa-arrow-right"></i></button>
                </form>
                <a href="products.html" class="btn btn-large"><i class="fa fa-arrow-left"></i> <s:message
                        code="cart.continueShoping"/> </a>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>
<script src="resources/js/cart.js"></script>
</body>
</html>
