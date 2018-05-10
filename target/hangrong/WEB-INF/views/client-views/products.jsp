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
<jsp:include page="../common/head.jsp"/>
<body>
<jsp:include page="../common/menu.jsp"/>
<jsp:include page="../common/slider.jsp"/>
<div id="mainBody">
    <div class="container">
        <div class="row">
            <jsp:include page="../common/sitebar.jsp"/>
            <div class="span9">
                <ul class="breadcrumb">
                    <li><a href="index.html"><s:message code="productDetail.Home" /></a> <span class="divider">/</span></li>
                    <c:if test="${isSearch}">
                        <li class="active"><s:message code="products.search" /> </li>
                    </c:if>
                    <c:if test="${!isSearch}">
                        <li class="active"><s:message code="products.product" /> </li>
                    </c:if>
                </ul>
                <c:if test="${isSearch}">
                    <h3><s:message code="products.searchResult" arguments="${totalResults},${key}" /> </h3>
                </c:if>
                <c:if test="${!isSearch&&shopId==null}">
                    <h3><s:message code="products.totalProducts" arguments="${totalResults}" /> </h3>
                </c:if>
                <c:if test="${shopId != null}">
                    <h3><s:message code="products.totalProductsOfShop" arguments="${totalResults},${products[0].shop.name}" /> </h3>
                </c:if>
                <hr class="soft"/>
                <br class="clr"/>
                <ul class="thumbnails">
                    <c:forEach items="${products}" var="product">
                        <li class="span3">
                            <div class="thumbnail">
                                <a href="products.html?productId=${product.id}"><img
                                        src="${product.image[0]}" alt="${product.name}"/></a>
                                <div class="caption">
                                    <h6 style="max-width: 90%;overflow: hidden;">${product.name}</h6>
                                    <h4 style="text-align:center"><a class="btn"
                                                                     href="products.html?productId=${product.id}"> <i
                                            class="fa fa-search-plus"></i></a> <a class="btn"
                                                                                  onclick="addToCart('${product.id}')">Add
                                        to <i class="fa fa-shopping-cart"></i></a> <a
                                            class="btn btn-primary" href="#">$${product.price}</a></h4>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
                <hr class="soft"/>
                <c:if test="${isSearch}">
                    <div class="pagination" style="margin-left: 30%;">
                        <ul>
                            <li>
                                <a href="search-product.html?key=${key}&categoryId=${categoryId}&page=${currentPage > 1 ? currentPage-1 : 1}">&lsaquo;&lsaquo;</a>
                            </li>
                            <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                                <li class="${currentPage == i?'active':''}"><a
                                        href="search-product.html?key=${key}&categoryId=${categoryId}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li>
                                <a href="search-product.html?key=${key}&categoryId=${categoryId}&page=${currentPage < totalPages ? currentPage+1 : totalPages}">&rsaquo;&rsaquo;</a>
                            </li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${!isSearch&&shopId==null}">
                    <div class="pagination" style="margin-left: 30%;">
                        <ul>
                            <li>
                                <a href="products.html?&categoryId=${categoryId}&page=${currentPage > 1 ? currentPage-1 : 1}">&lsaquo;&lsaquo;</a>
                            </li>
                            <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                                <li class="${currentPage == i?'active':''}"><a
                                        href="products.html?&categoryId=${categoryId}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li>
                                <a href="products.html?&categoryId=${categoryId}&page=${currentPage < totalPages ? currentPage+1 : totalPages}">&rsaquo;&rsaquo;</a>
                            </li>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${shopId != null}">
                    <div class="pagination" style="margin-left: 30%;">
                        <ul>
                            <li>
                                <a href="products.html?&shopId=${shopId}&page=${currentPage > 1 ? currentPage-1 : 1}">&lsaquo;&lsaquo;</a>
                            </li>
                            <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                                <li class="${currentPage == i?'active':''}"><a
                                        href="products.html?&shopId=${shopId}&page=${i}">${i}</a>
                                </li>
                            </c:forEach>
                            <li>
                                <a href="products.html?&shopId=${shopId}&page=${currentPage < totalPages ? currentPage+1 : totalPages}">&rsaquo;&rsaquo;</a>
                            </li>
                        </ul>
                    </div>
                </c:if>
                <br class="clr"/>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>
