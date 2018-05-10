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
                <h2 style="text-align: center;font-weight: bold">Sản phẩm trong cửa
                    hàng ${sessionScope.currentUser.name}</h2>
            </div>
        </div>
        <hr>
        <div class="searchform">
            <form action="shop-management.html?search-product" method="post" class="navbar-form" style="margin:0 50% 2% 0;">
                <input name="key" type="text" class="form-control" placeholder="Tìm kiếm">
                <button class="btn btn-default"><i class="fa fa-search"></i> Tìm kiếm</button>
            </form>
        </div>
        <div class="row">
            <div class="col-md-9 col-sm-12 col-xs-12">
                <div class="panel panel-default"
                     style="width:1200px; max-height:600px; margin-bottom:30px;">
                    <div class="panel-heading">
                        <c:if test="${isSearch}">
                            Tìm thấy <b>${totalProducts}</b> sản phẩm với từ khóa <b>'${key}'</b>
                        </c:if>
                        <c:if test="${!isSearch}">
                            Có tất cả ${totalProducts} sản phẩm trong cửa hàng
                        </c:if>
                    </div>
                    <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>#</th>
                                    <th style="text-align: center;">Hình ảnh</th>
                                    <th style="text-align: center;">Tên sản phẩm</th>
                                    <th style="text-align: center;">Giá</th>
                                    <th style="text-align: center;">Trạng Thái</th>
                                    <th style="text-align: center;">Thể loại</th>
                                    <th style="text-align: center;">Ngày đăng bán</th>
                                    <th style="text-align: center;">Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${products}" var="product" varStatus="i">
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
                            <c:if test="${!isSearch}">
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
                            </c:if>
                            <c:if test="${isSearch}">
                                <li>
                                    <a href="${currentPage > 1 ? 'shop-management.html?key='+key+'page='+=(currentPage - 1) : '#'} "
                                       aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach var="index" begin="1" end="${totalPages}">
                                    <li class="${currentPage == index?'active':''}"><a
                                            href="shop-management.html?key=${key}&page=${index}">${index}</a></li>
                                </c:forEach>
                                <li>
                                    <a href="${currentPage < totalPages ? 'shop-management.html?key='+key+'page='+=(currentPage + 1) : '#'}"
                                       aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <c:if test="${deleteSucceed != null}">
        <script>
            showPopup("Thông báo", "Xoá thành công sản phẩm <b>${deleteSucceed}</b> !");
        </script>
    </c:if>
    <c:if test="${editInfoSucceed}">
        <script>
            showPopup("Thông báo", "Cập nhật thông tin thành công !");
        </script>
    </c:if>
    <c:if test="${changePassSucceed}">
        <script>
            showPopup("Thông báo", "Thay đổi mật khẩu thành công !");
        </script>
    </c:if>
</div>
</body>
</html>

