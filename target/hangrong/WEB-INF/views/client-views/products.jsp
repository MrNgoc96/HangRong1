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
                    <li><a href="index.html">Home</a> <span class="divider">/</span></li>
                    <li class="active">Products Name</li>
                </ul>
                <h3> Products Name
                    <small class="pull-right"></small>
                </h3>
                <hr class="soft"/>
                <br class="clr"/>
                <div class="tab-content">
                    <div class="tab-pane  active" id="blockView">
                        <ul class="thumbnails">
                            <c:forEach items="${products}" var="product">
                                <li class="span3">
                                    <div class="thumbnail">
                                        <a href="products.html?productId=${product.id}"><img
                                                src="${product.image[0]}" alt="${product.name}"/></a>
                                        <div class="caption">
                                            <h5>${product.name}</h5>
                                            <h4 style="text-align:center"><a class="btn" href="products.html?productId=${product.id}"> <i
                                                    class="fa fa-search-plus"></i></a> <a class="btn" onclick="addToCart('${product.id}')">Add
                                                to <i class="fa fa-shopping-cart"></i></a> <a
                                                    class="btn btn-primary" href="#">$${product.price}</a></h4>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <hr class="soft"/>
                    </div>
                </div>
                <div class="pagination">
                    <ul>
                        <li><a href="search-product.html?key=${key}&categoryId=${categoryId}&page=${page > 1 ? page-1 : 1}">&lsaquo;</a></li>
                        <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                            <li><a href="search-product.html?key=${key}&categoryId=${categoryId}&page=${i}" class="${currentPage == i ? 'active' : ''}">${i}</a></li>
                        </c:forEach>
                        <li><a href="search-product.html?key=${key}&categoryId=${categoryId}&page=${page < totalPages ? page+1 : totalPages}">&rsaquo;</a></li>
                    </ul>
                </div>
                <br class="clr"/>
            </div>
        </div>
    </div>
</div>
<jsp:include page="../common/footer.jsp"/>
</body>
</html>
