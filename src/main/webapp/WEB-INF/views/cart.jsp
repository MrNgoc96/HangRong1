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
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<html>
<jsp:include page="head.jsp"/>
<body>
<jsp:include page="menu.jsp"/>
<div id="mainBody">
    <div class="container">
        <div class="row">
            <jsp:include page="sitebar.jsp"/>
            <div class="span9">
                <ul class="breadcrumb">
                    <li><a href="index.html">Home</a> <span class="divider">/</span></li>
                    <li class="active"> SHOPPING CART</li>
                </ul>
                <c:set var="cartBean" value="${sessionScope.cartBean}"/>
                <h3><s:message code="cart.has"/> ${fn:length(cartBean)} <s:message code="cart.products"/> <a
                        href="home.html" class="btn btn-large pull-right"><i
                        class="fa fa-arrow-left"></i> Continue
                    Shopping </a></h3>
                <hr class="soft"/>
                <table class="table table-bordered" id="cart">
                    <thead>
                    <tr>
                        <th>Product</th>
                        <th>Product Name</th>
                        <th>Quantity/Update</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:set var="totalPrice" value="0"/>
                    <c:forEach items="${cartBean}" var="item">
                        <c:set var="totalPrice"
                               value="${totalPrice = totalPrice + (item.value.product.price * item.value.quantity)}"></c:set>
                        <tr>
                            <td><img width="60" src="${item.value.product.image[0]}" alt=""/></td>
                            <td>${item.value.product.name}</td>
                            <td>
                                <div class="input-append"><input class="span1" style="max-width:34px;height: 25px;"
                                                                 value="${item.value.quantity}"
                                                                 id="productQuantity" size="16" type="text">
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
                            <td>$${item.value.product.price * item.value.quantity}</td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="4" style="text-align:right"><strong>TOTAL :</strong></td>
                        <td class="label label-important" style="display:block"><strong> $${totalPrice} </strong></td>
                    </tr>
                    </tbody>
                </table>


                <table class="table table-bordered">
                    <tbody>
                    <tr>
                        <td>
                            <form class="form-horizontal">
                                <div class="control-group">
                                    <label class="control-label"><strong> VOUCHERS CODE: </strong> </label>
                                    <div class="controls">
                                        <input type="text" class="input-medium" placeholder="CODE">
                                        <button type="submit" class="btn"> ADD</button>
                                    </div>
                                </div>
                            </form>
                        </td>
                    </tr>

                    </tbody>
                </table>

                <table class="table table-bordered">
                    <tr>
                        <th>ESTIMATE YOUR SHIPPING</th>
                    </tr>
                    <tr>
                        <td>
                            <form class="form-horizontal">
                                <div class="control-group">
                                    <label class="control-label" for="inputCountry">Country </label>
                                    <div class="controls">
                                        <input type="text" id="inputCountry" placeholder="Country">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <label class="control-label" for="inputPost">Post Code/ Zipcode </label>
                                    <div class="controls">
                                        <input type="text" id="inputPost" placeholder="Postcode">
                                    </div>
                                </div>
                                <div class="control-group">
                                    <div class="controls">
                                        <button type="submit" class="btn">ESTIMATE</button>
                                    </div>
                                </div>
                            </form>
                        </td>
                    </tr>
                </table>
                <a href="products.html" class="btn btn-large"><i class="fa fa-arrow-left"></i> Continue Shopping </a>
                <a href="login.html" class="btn btn-large pull-right">Next <i class="fa fa-arrow-right"></i></a>

            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
