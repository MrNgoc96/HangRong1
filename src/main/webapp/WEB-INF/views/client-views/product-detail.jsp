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
<jsp:include page="../common/head.jsp" />
<body>
<script src="resources/js/product-detail.jsp.js"></script>
<jsp:include page="../common/menu.jsp"/>
<jsp:include page="../common/slider.jsp"/>
<div id="mainBody">
    <div class="container">
        <div class="row">
            <jsp:include page="../common/sitebar.jsp"/>
            <div class="span9">
                <ul class="breadcrumb">
                    <li><a href="home.html"><s:message code="productDetail.Home" /></a> <span class="divider">/</span></li>
                    <li><a href="products.html"><s:message code="productDetail.product" /></a> <span class="divider">/</span></li>
                    <li class="active"><s:message code="productDetail.productDetail" /></li>
                </ul>
                <div class="row">
                    <div id="gallery" class="span3">
                        <a href="${product.image[0]}" title="${product.name}">
                            <img src="${product.image[0]}" style="width:100%"
                                 alt="${product.name}"/>
                        </a>
                        <div id="differentview" class="moreOptopm carousel slide">
                            <div class="carousel-inner">
                                <div class="item active">
                                    <c:forEach items="${product.image}" var="image" begin="1">
                                        <a href="${image}"> <img style="width:29%"
                                                                 src="${image}"
                                                                 alt=""/></a>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="btn-toolbar">
                            <div class="btn-group" style="margin-left: 20%;">
                                <span class="btn" id="love"><i class="fa fa-star"></i></span>
                                <span class="btn" id="like"><i class=" fa fa-thumbs-up"></i></span>
                                <span class="btn" id="dislike"><i class="fa fa-thumbs-down"></i></span>
                            </div>
                        </div>
                    </div>
                    <div class="span6">
                        <h3>${product.name}</h3>
                        <hr class="soft"/>
                        <form class="form-horizontal qtyFrm">
                            <div class="control-group">
                                <label class="control-label"><span style="color: red;font-weight: bold;"><s:message code="productDetail.price" /> : $${product.price}</span></label>
                                <div class="controls">
                                    <button type="button" onclick="addToCart('${product.id}')" class="btn btn-large btn-primary pull-right"><s:message code="productDetail.addToCart" /> <i
                                            class=" fa fa-shopping-cart"></i></button>
                                </div>
                            </div>
                        </form>
                        <hr class="soft clr"/>
                        <p>
                            ${product.intro}
                        </p>
                        <a class="btn btn-small pull-right" href="#detail">More Details</a>
                        <br class="clr"/>
                        <a href="#" name="detail"></a>
                        <hr class="soft"/>
                        <h4><s:message code="productDetail.publishBy" /> <a style="color: #1f6377">${shop.name}</a></h4>
                        <img src="${shop.avatar}" class="img-rounded" width="50%">
                        <h5><s:message code="productDetail.saleLevel" />: ${shop.level}</h5>
                        <h5><s:message code="productDetail.joinDate" />: ${shop.joinDate}</h5>
                    </div>

                    <div class="span9">
                        <ul id="productDetail" class="nav nav-tabs">
                            <li class="active"><a href="#detail" data-toggle="tab"><s:message code="productDetail.productDetail" /></a></li>
                            <li><a href="#profile" data-toggle="tab"><s:message code="productDetail.RelatedProducts" /></a></li>
                        </ul>
                        <div id="myTabContent" class="tab-content">
                            <div class="tab-pane fade active in" id="detail">
                                <h4><s:message code="productDetail.ProductInformation" /></h4>
                                <table class="table table-bordered">
                                    <tbody>
                                    <tr class="techSpecRow">
                                        <th colspan="2"><s:message code="productDetail.productDetail" /></th>
                                    </tr>
                                    <c:forEach items="${product.detail}" var="detail">
                                        <tr>
                                            <c:forTokens items="${detail}" delims=":" var="item" varStatus="i">
                                                <c:if test="${i.index == 0}">
                                                    <td>${item} :</td>
                                                </c:if>
                                                <c:if test="${i.index == 1}">
                                                    <td>${item}</td>
                                                </c:if>
                                            </c:forTokens>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="tab-pane" id="profile">
                                <br class="clr"/>
                                <hr class="soft"/>
                                        <ul class="thumbnails">
                                            <c:forEach items="${relatedProducts}" var="product">
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
                                <br class="clr">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                <div id="comment" style="position:relative;margin-left: 25%;">
                    <fieldset>
                        <legend>Bình luận</legend>
                        <form>
                            <table>
                                <tr>
                                    <td>Tiêu đề : </td>
                                    <td><input type="text" style="width: 200%;height: 5%"/></td>
                                </tr>
                                <tr>
                                    <td>Tin nhắn : </td>
                                    <td><textarea style="width: 200%;height: 50%" maxlength="4000"  placeholder="Để lại bình luận của bạn!"></textarea></td>
                                </tr>
                                <tr>
                                    <td><input type="submit" class="btn btn-success" value="Gửi" style="width:80px; height:30px; position:absolute;margin-left:85px;" />
                                    <td><input type="reset" class="btn btn-danger" value="Nhập lại"  style="width:80px; height:30px; position:absolute;margin-left:105px;"/>
                                </tr>
                            </table>
                        </form>
                    </fieldset>
                </div>
                <div class="showcomment"></div>
                <br>
                <hr>
                <div id="showcomment">
                    <table class="table">
                        <thead class="thead-dark">
                        <tr>
                            <H4><b>Nhận xét về sản phẩm</b></H4>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <th scope="row">Tên:</th>
                            <td><textarea cols="60" rows="5" maxlength="4000" style="width:800px;height:50px;"></textarea></td>
                            <td>2/11/2018</td>
                        </tr>
                        <tr>
                            <th scope="row">Tên:</th>
                            <td><textarea cols="60" rows="5" maxlength="4000" style="width:800px;height:70px;"></textarea></td>
                            <td>2/11/2018</td>
                        </tr>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
</body>
</html>
