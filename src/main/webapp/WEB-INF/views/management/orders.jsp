<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<body>
<!-- /. NAV SIDE  -->
<div id="page-wrapper">
    <div id="page-inner">
        <div class="row">
            <div class="col-md-12">
                <h2 style="text-align: center;font-weight: bold">Quản lý đơn hàng ${sessionScope.currentUser.name}</h2>
            </div>
        </div>
        <c:if test="${updateOrderSucceed}">
            <script>
                showPopup("Thông báo", "Cập nhật tình trạng đơn hàng thành công !");
            </script>
        </c:if>
        <c:if test="${deleteOrderSucceed}">
            <script>
                showPopup("Thông báo", "Xóa đơn hàng thành công !");
            </script>
        </c:if>
        <hr>
        <div class="searchform">
            <form class="navbar-form" role="search" style="margin:0 50% 2% 0;">
                <select name="categoryId" class="form-control">

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
                                    <th style="text-align: center;">Mã đơn hàng</th>
                                    <th style="text-align: center;">Tên khách hàng</th>
                                    <th style="text-align: center;">Email khách hàng</th>
                                    <th style="text-align: center;">Địa chỉ nhận hàng</th>
                                    <th style="text-align: center;">Ngày đặt hàng</th>
                                    <th style="text-align: center;">Trạng thái</th>
                                    <th style="text-align: center;">Hành động</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${orders}" var="order" varStatus="i">
                                        <tr style="text-align: center;">
                                            <td>DH${order.id}</td>
                                            <td>${order.customer.name}</td>
                                            <td>${order.customer.email}</td>
                                            <td>${order.address} </td>
                                            <td>${order.orderDate}</td>
                                            <td>${order.totalPrice}$</td>
                                            <td>
                                                <c:if test="${orderStatus<3}">
                                                    <a class="btn btn-success" onclick="updateOrderStatus('${order.id}','${orderStatus}')"><i class="fa fa-level-up"></i></a>
                                                </c:if>
                                                <a class="btn btn-danger" onclick="deleteOrder('${order.id}')"><i class="fa fa-trash-o"></i></a>
                                                <a class="btn btn-primary" data-toggle="modal"
                                                   data-target="#orderDetail" onclick="viewOrder('${order.id}')"><i
                                                        class="fa fa-search-plus"></i></a>
                                            </td>
                                        </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <ul class="pagination" style="margin-left: 40%;">
                            <li>
                                <a href="${currentPage > 1 ? 'shop-management.html?managementOrders&page='+=(currentPage - 1) : '#'} "
                                   aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <c:forEach var="index" begin="1" end="${totalPages}">
                                <li class="${currentPage == index?'active':''}"><a
                                        href="shop-management.html?managementOrders&page=${index}">${index}</a></li>
                            </c:forEach>
                            <li>
                                <a href="${currentPage < totalPages ? 'shop-management.html?managementOrders&page='+=(currentPage + 1) : '#'}"
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
    <div class="modal fade" id="orderDetail" tabindex="-1" role="dialog"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Chi tiết đơn hàng ${orderDetails[0].order.status}</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="orderDetails">
                    <table class="table">
                        <thead>
                        <tr style="text-align: center;">
                            <th scope="col">STT</th>
                            <th scope="col">Hình ảnh</th>
                            <th scope="col">Tên sản phẩm</th>
                            <th scope="col">Giá</th>
                            <th scope="col">Khuyến mại</th>
                            <th scope="col">Số lượng</th>
                            <th scope="col">Thành tiền</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${orderDetails}" var="od" varStatus="i">
                            <tr style="text-align: center;">
                                <th scope="row">${i.index + 1}</th>
                                <td style="width: 20%;"><img src="${od.product.image[0]}" width="60%"></td>
                                <td style="width: 40%;color: #1f6377">${od.product.name}</td>
                                <td style="color: #009B50;">${od.product.price}$</td>
                                <td style="color: red;"><fmt:formatNumber value="${od.product.discount}"
                                                                          type="percent"/></td>
                                <td style="color:#2a6496;">${od.quantity}</td>
                                <td style="color:red;font-weight: bold;">${od.quantity * od.product.newPrice}$</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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

