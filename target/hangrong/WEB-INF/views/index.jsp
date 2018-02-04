<%--
  Created by IntelliJ IDEA.
  User: longoc
  Date: 18/01/2018
  Time: 23:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>
<html>
<jsp:include page="head.jsp"/>
<body>
<jsp:include page="menu.jsp"/>
<jsp:include page="slider.jsp"/>
<div id="mainBody">
    <div class="container">
        <div class="row">
            <jsp:include page="sitebar.jsp"/>
            <div class="span9">
                <div class="well well-small">
                    <h4> <s:message code="home.latestProduct" />
                        <small class="pull-right"></small>
                    </h4>
                    <div class="row-fluid">
                        <div id="featured" class="carousel slide">
                            <div class="carousel-inner">
                                <div class="item active">
                                    <ul class="thumbnails">
                                        <c:forEach items="${newProducts}" var="product" end="3">
                                            <li class="span3">
                                                <div class="thumbnail">
                                                    <i class="tag"></i>
                                                    <a href="products.html?productId=${product.id}">
                                                        <img src="${product.image[0]}" alt="${product.name}">
                                                    </a>
                                                    <div class="caption">
                                                        <h6>${product.name}</h6>
                                                        <h4>
                                                            <a class="btn" href="products.html?productId=${product.id}"><s:message code="home.view" /></a>
                                                            <span class="pull-right">$${product.price}</span>
                                                        </h4>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                                <div class="item">
                                    <ul class="thumbnails">
                                        <c:forEach items="${newProducts}" var="product" begin="4">
                                            <li class="span3">
                                                <div class="thumbnail">
                                                    <i class="tag"></i>
                                                    <a href="products.html?productId=${product.id}">
                                                        <img src="${product.image[0]}" alt="${product.name}">
                                                    </a>
                                                    <div class="caption">
                                                        <h6>${product.name}</h6>
                                                        <h4>
                                                            <a class="btn" href="products.html?productId=${product.id}"><s:message code="home.view" /></a>
                                                            <span class="pull-right">$${product.price}</span>
                                                        </h4>
                                                    </div>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <a class="left carousel-control" href="#featured" data-slide="prev">‹</a>
                            <a class="right carousel-control" href="#featured" data-slide="next">›</a>
                        </div>
                    </div>
                </div>
                <h4><s:message code="home.featuredProducts" /></h4>
                <ul class="thumbnails">
                    <c:forEach items="${featureProducts}" var="product">
                        <li class="span3">
                            <div class="thumbnail">
                                <a href="products.html?productId=${product.id}">
                                    <img src="${product.image[0]}" alt=""/>
                                </a>
                                <div class="caption">
                                    <h6>${product.name}</h6>
                                    <h4 style="text-align:center">
                                        <a class="btn" href="products.html?productId=${product.id}">
                                            <i class="fa fa-search-plus"></i>
                                        </a>
                                        <a class="btn" onclick="addToCart('${product.id}')"><s:message code="home.addTo" />
                                            <i class="fa fa-shopping-cart"></i>
                                        </a>
                                        <a class="btn btn-primary" href="#">$${product.price}</a>
                                    </h4>
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp"/>
</body>
</html>
