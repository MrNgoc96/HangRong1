<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<!-- /. NAV SIDE  -->
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2 style="text-align: center;font-weight: bold">Quản lý tài khoản</h2>
            </div>
        </div>
        <hr>
        <div class="searchform">
            <form class="navbar-form" role="search" style="margin:0 50% 2% 0;">
                <select name="categoryId" class="form-control">
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.id}">${category.name}</option>
                    </c:forEach>
                </select>
                <input type="text" class="form-control" placeholder="Tìm kiếm">
                <button type="submit" class="btn btn-default"><i class="fa fa-search"></i> Tìm kiếm</button>
            </form>
        </div>
        <div class="row">
            <div class="col-md-9 col-sm-12 col-xs-12">
                <div class="panel panel-default"
                     style="width:1200px; max-height:600px; margin-bottom:30px;">
                    <div class="panel-heading">
                        <ul class="nav nav-pills">
                            <li class="${orderStatus==1?'active':''}"><a
                                    href="shop-management.html?managementOrders&orderStatus=1" class="tab">Đang đặt
                                hàng <span class="badge">${status1}</span></a></li>
                            <li class="${orderStatus==2?'active':''}"><a
                                    href="shop-management.html?managementOrders&orderStatus=2" class="tab">Đang giao
                                hàng <span class="badge">${status2}</span></a></li>
                            <li class="${orderStatus==3?'active':''}"><a
                                    href="shop-management.html?managementOrders&orderStatus=3" class="tab">Đã nhận
                                hàng <span class="badge">${status3}</span></a></li>
                            <li class="${orderStatus==4?'active':''}"><a
                                    href="shop-management.html?managementOrders&orderStatus=4" class="tab">Yêu cầu hủy
                                đặt hàng <span class="badge">${status4}</span></a></li>
                        </ul>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th style="text-align: center;">Email</th>
                                    <th style="text-align: center;">Tên sản phẩm</th>
                                    <th style="text-align: center;">Giá</th>
                                    <th style="text-align: center;">Trạng Thái</th>
                                    <th style="text-align: center;">Thể loại</th>
                                    <th style="text-align: center;">Ngày đăng bán</th>
                                    <th style="text-align: center;">Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${shop}" var="product" varStatus="i">
                                    <tr style="text-align: center;">
                                        <td>${i.index + 1}</td>
                                        <td width="200px"><img src="${product.image[0]}" width="50%"></td>
                                        <td>${product.name}</td>
                                        <td style="width: 100px;">$${product.price}</td>
                                        <td>${product.status==true?'Còn hàng':'Hết hàng'}</td>
                                        <td>${product.category.name}</td>
                                        <td>${product.saleDate}</td>
                                        <td>
                                            <a href="shop-management.html?editProduct&productId=${product.id}">
                                                <button class="btn btn-success"><i class="fa fa-pencil"></i>
                                                </button>
                                            </a>
                                            <span class="hidden" id="del-product-confirm-title"><s:message
                                                    code="confirm.deleteProduct.title"/></span>
                                            <span class="hidden" id="del-product-confirm-message"><s:message
                                                    code="confirm.deleteProduct.message"
                                                    arguments="${product.name}"/></span>
                                            <span class="hidden" id="del-product-confirm-yes"><s:message
                                                    code="confirm.deleteProduct.yes"/></span>
                                            <span class="hidden" id="del-product-confirm-no"><s:message
                                                    code="confirm.deleteProduct.no"/></span>
                                            <a href="#" onclick="deleteProduct('${product.id}')">
                                                <button class="btn btn-danger"><i class="fa fa-trash"></i></button>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                        </div>
                        <ul class="pagination" style="margin-left: 40%;">
                            <li>
                                <a href="${currentPage > 1 ? 'shop-management.html?page='+=(currentPage - 1) : '#'} "
                                   aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <c:forEach var="index" begin="1" end="${totalPages}">
                                <li class="${currentPage == index?'active':''}"><a
                                        href="shop-management.html?page=${index}">${index}</a></li>
                            </c:forEach>
                            <li>
                                <a href="${currentPage < totalPages ? 'shop-management.html?page='+=(currentPage + 1) : '#'}"
                                   aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <c:if test="${deleteSucceed != null}">
        <span class="hidden" id="title"><s:message code="shop-management.product.popup-title"/></span>
        <span class="hidden" id="message"><s:message code="shop-management.product.deleteSucceed"
                                                     arguments="${deleteSucceed}"/></span>
        <script>
            let title = $('#title').text();
            let msg = $('#message').text()
            showPopup(title, msg);
        </script>
    </c:if>
</div>
</body>
</html>

